var restify = require('restify');
var fs = require('fs');
var easyimg = require('easyimage');

function circleImageAction(req, res, next) {

    var base64Data = req.params.imageData.replace(/^data:image\/jpeg;base64,/, "");
    fs.writeFile("out.jpg", base64Data, 'base64', function(err) {
        if (!err) {
            var fullPath = __dirname + '/out.jpg';

            var command = 'convert -size 200x200 xc:none -fill '+fullPath+' -stroke black -strokewidth 5 -draw "circle 100,100 100,1" -bordercolor "#000" circle_thumb.png';
            easyimg.exec(command).then(
                function () {

                    var circleImageFullPath = __dirname + '/circle_thumb.png';
                    fs.readFile(circleImageFullPath, function(err, original_data){
                        var base64Image = new Buffer(original_data, 'binary').toString('base64');
                        console.log(base64Image);
                        res.send(base64Image);
                    });

                }, function (err) {
                    console.log(err);
                    res.send(400, err);
                }
            );

        } else {
            console.log(err);
            res.send(400, err);
        }
    });

}

var server = restify.createServer();
server.pre(restify.pre.sanitizePath());
server.use(restify.acceptParser(server.acceptable));
server.use(restify.dateParser());
server.use(restify.queryParser());
server.use(restify.bodyParser());
server.use(restify.gzipResponse());
server.use(restify.CORS());
server.use(restify.fullResponse());
server.post('/image-as-circle', circleImageAction);

server.listen(process.env.PORT || 8090, function() {
    console.log('%s listening at %s', server.name, server.url);
});
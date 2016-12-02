var easyimg = require('easyimage');

function makeCircle(path) {
    var command = 'convert -size 200x200 xc:none -fill '+path+' -stroke black -strokewidth 5 -draw "circle 100,100 100,1" -bordercolor "#000" circle_thumb.png';
    easyimg.exec(command).then(
        function () {

        }, function (err) {
            console.log(err);
        }
    );
}

var path = '/home/ryuk/lfreneda/work/others/playing-with-images/mad.jpg';
makeCircle(path);
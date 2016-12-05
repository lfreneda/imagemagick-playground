waterfall = require('async').waterfall
parallel = require('async').parallel
easyimg = require 'easyimage'
fs = require 'fs'

onErr = (err) -> console.log err

toDisk = (callback) ->
  callback null, {
    originalFilePath: '/home/ryuk/lfreneda/work/others/playing-with-images/mad.jpg'
  }

thumbnails = (options, callback) ->
  destinationFilePath = __dirname + '/output/mad_thumbnail.jpg'
  onOk = () ->
    options.thumbnailFilePath = destinationFilePath
    callback null, options
  easyimg.thumbnail({
    src: options.originalFilePath
    dst: destinationFilePath,
    width:200
    height:200
  }).then onOk, onErr

circleImageDefaultColor = (options, callback) ->
  destinationFilePath = __dirname + '/output/mad_thumbnail-circle.png'
  command = 'convert -size 200x200 xc:none -fill '+options.thumbnailFilePath+' -draw "circle 100,100 100,1" ' + destinationFilePath
  onOk = () ->
    options.thumbnailCircleFilePath = destinationFilePath
    callback null, options
  easyimg.exec(command).then onOk, onErr

drawCircleOnCircleImage = (options, callback) ->
  destinationFilePath = __dirname + '/output/mad_thumbnail-circle-offline-aaaaaaaa.png'
  command = 'convert -size 200x200 xc:none '+options.thumbnailCircleFilePath+' -draw "circle 80,60 120,30" xc:black ' + destinationFilePath;
  console.log command
  easyimg.exec(command).then () ->
    options.thumbnailCircleOfflineFilePath = destinationFilePath
    callback null, options
#
#circleImageOfflineColor = (options, callback) ->
#  destinationFilePath = __dirname + '/output/mad_thumbnail-circle-offline.png'
#  command = 'convert -size 200x200 xc:none -fill '+options.thumbnailFilePath+' -stroke "#A50000" -strokewidth 10 -draw "circle 100,100 100,1" ' + destinationFilePath;
#  # console.log command
#  easyimg.exec(command).then () ->
#    options.thumbnailCircleOfflineFilePath = destinationFilePath
#    callback null, options
#
#circleImageOnlineColor = (options, callback) ->
#  destinationFilePath = __dirname + '/output/mad_thumbnail-circle-online.png'
#  command = 'convert -size 200x200 xc:none -fill '+options.thumbnailFilePath+' -stroke "#1B5E20" -strokewidth 10 -draw "circle 100,100 100,1" ' + destinationFilePath;
#  # console.log command
#  easyimg.exec(command).then () ->
#    options.thumbnailCircleOnlineFilePath = destinationFilePath
#    callback null, options
#
pinOnline = (options, callback) ->
  destinationFilePath = __dirname + '/output/pin-online.png'

  onOk = () ->
    options.thumbnailPinCircleOnlineFilePath = destinationFilePath
    callback null, options

  easyimg.thumbnail({
    src: '/home/ryuk/lfreneda/work/others/playing-with-images/c.png'
    dst: destinationFilePath,
    width:32
    height:32
  }).then onOk, onErr

pinOffline = (options, callback) ->
  destinationFilePath = __dirname + '/output/pin-offline.png'

  onOk = () ->
    options.thumbnailPinCircleOfflineFilePath = destinationFilePath
    callback null, options

  easyimg.thumbnail({
    src: '/home/ryuk/lfreneda/work/others/playing-with-images/d.png'
    dst: destinationFilePath
    width:32
    height:32
  }).then onOk, onErr

waterfall [
  toDisk
#  thumbnails
#  circleImageDefaultColor
#  drawCircleOnCircleImage
#  circleImageOfflineColor
#  circleImageOnlineColor
  pinOnline
  pinOffline

], (err, result) ->
  if err
    console.log err
  else
    console.log JSON.stringify(result.output)






// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require tether
//= require bootstrap-sprockets
//= require_tree .

function preview_photo(file,index){
  var MAXWIDTH  = 80;
  var MAXHEIGHT = 80;
  if (file.files && file.files[0])
  {
    var img = document.getElementById('photo'+index);
    img.onload = function(){
      var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
      img.width  =  rect.width;
      img.height =  rect.height;
      img.style.marginTop = rect.top+'px';
    }
    var reader = new FileReader();
    reader.onload = function(evt){img.src = evt.target.result;}
    reader.readAsDataURL(file.files[0]);
  }
  else //兼容IE
  {
    var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
    file.select();
    var src = document.selection.createRange().text;
    var img = document.getElementById('photo'+index);
    img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
    var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
    status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
    div.innerHTML = "<div id=divhead style='width:"+rect.width+"px;height:"+rect.height+"px;margin-top:"+rect.top+"px;"+sFilter+src+"\"'></div>";
  }
  $("#photodiv"+index).show();
  if($("#uploaddiv"+(index+1))){
    $("#uploaddiv"+(index+1)).show();
  }
  $("#uploaddiv"+index).hide();
}

function delete_photo(index){
  if($("#uploaddiv"+(index+1))){
    if($("#photograph_photos_attributes_"+(index+1)+"_photo").prop('files').size > 0){
      $("#photograph_photos_attributes_"+index+"_photo").prop('files', $("#photograph_photos_attributes_"+(index+1)+"_photo").prop('files'));
      $("#photodiv"+index).html($("#photodiv"+(index+1)).html());
      delete_photo(index+1);
    }else{
      $("#photograph_photos_attributes_"+index+"_photo").val('');
      $("#photodiv"+index).hide();
    }
  }
}

function clacImgZoomParam( maxWidth, maxHeight, width, height ){
  var param = {top:0, left:0, width:width, height:height};
  if( width>maxWidth || height>maxHeight )
  {
    rateWidth = width / maxWidth;
    rateHeight = height / maxHeight;

    if( rateWidth > rateHeight )
    {
      param.width =  maxWidth;
      param.height = Math.round(height / rateWidth);
    }else
    {
      param.width = Math.round(width / rateHeight);
      param.height = maxHeight;
    }
  }

  param.left = Math.round((maxWidth - param.width) / 2);
  param.top = Math.round((maxHeight - param.height) / 2);
  return param;
}

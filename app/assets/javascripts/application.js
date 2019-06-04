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
//= require swiper
//= require jquery-weui/popup
//= require jquery-weui/transition
//= require fastclick
//= require jquery.validate.min
//= require exif-js


// 手机号码验证
//$.validator.addMethod("cnmobile", function(value, element) {
//    var length = value.length;
//    var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
//    return this.optional(element) || (length == 11 && mobile.test(value));
//}, "请正确填写您的手机号码");

$(function() {
  FastClick.attach(document.body);

  //remove link from iphone alert
  window.alert = function(name) {
    var iframe = document.createElement("IFRAME");
    iframe.style.display = "none";
    iframe.setAttribute("src", 'data:text/plain,');
    document.documentElement.appendChild(iframe);
    window.frames[0].window.alert(name);
    iframe.parentNode.removeChild(iframe);
  };
  $('#iosDialog2').on('click', '.weui-dialog__btn', function() {
    $(this).parents('.js_dialog').fadeOut(200);
  });

  var img_width = 751;
  var img_height = 501;
  var avatar_radius = 50;
  var window_width = $(window).width();
  var footer_width = Math.floor(window_width / 5);
  var footer_height = Math.floor((footer_width * 108) / 151);
  var footer_text_top = Math.floor(footer_height * 0.65);
  //$(".footer_on").css("width",footer_width+"px")
  $(".footer_on").css("height", footer_height + "px")
  //$(".footer_off").css("width",footer_width+"px")
  $(".footer_off").css("height", footer_height + "px")
  $(".footer_text").css("padding-top", footer_text_top + "px")

  var poster_width = 640;
  var poster_height = 1708;
  if (window_width > poster_width) {
    var poster_fit_width = poster_width;
  } else {
    var poster_fit_width = window_width;
  }
  var rate = (poster_fit_width / poster_width);
  //var poster_link = [38, 300, 145, 335];
  var poster_link = [0, 255, 200, 370];
  var coords = "";
  coords += Math.floor(rate * poster_link[0]).toString() + ",";
  coords += Math.floor(rate * poster_link[1]).toString() + ",";
  coords += Math.floor(rate * poster_link[2]).toString() + ",";
  coords += Math.floor(rate * poster_link[3]).toString();
  $("#area").attr("coords", coords)

  if ($("#cover").length > 0) {
    var height = Math.floor((window_width * 501) / 751);
    $("#cover").css("width", window_width + "px");
    $("#cover").css("height", height + "px");
    $("#cover_table").css("padding-top", (height - avatar_radius) + "px");
  }

  $("#my_work").on('click', function() {
    $(this).css('border-bottom-width', '2px');
    $("#my_card").css('border-bottom-width', '1px');
    $("#works").show();
    $("#cards").hide();
  });
  $("#my_card").on('click', function() {
    $(this).css('border-bottom-width', '2px');
    $("#my_work").css('border-bottom-width', '1px');
    $("#works").hide();
    $("#cards").show();
  });


  //$(".photo_item").on("swipeleft",function(){
  //  alert("You swiped left!");
  //  if($(this).prev()){
  //    $(this).hide();
  //    $(this).prev().show();
  //  }
  //});

  //$(".photo_item").on("swiperight",function(){
  //  alert("You swiped right!");
  //  if($(this).next()){
  //    $(this).hide();
  //    $(this).next().show();
  //  }
  //});
  $(".swiper-container").swiper({
    pagination: '.swiper-pagination',
    paginationType: 'bullets',
    paginationClickable: true,
    speed: 500,
    autoplay: 3500,
    loop: true
  });

});

// 用户提交
// $(document).on('click', '#submitPhotoBtn', function(){
//   // 不需要发送file， use base64
//   var form = $(".photograph_form")
//   $.ajax( { url:  form.attr('action') , type:form.attr('method'), dataType: 'json',
//     data: $(".photograph_form").serialize(),
//     success: function(data){
//       //设置投票对象ID
//       console.log(data);
//     }
//   });
// })
//title: "活动介绍",
//text: <%== ( render :partial => 'intro',:formats=>[:html] ).to_json %>,
//buttons: [{ text: "关闭", onClick: function(){ $.closeModal();} } ]
// title, text, buttons
function custom_popup(options) {
  $(".weui-popup__modal").html(options.text);
  $(".weui-popup__container").popup();
}

function refresh_rest(input_id, rest_id, total) {
  var input = $("#" + input_id).val();
  var rest = total - input.length;
  $("#" + rest_id).html('（剩余' + rest + '字符）');
}

function ShowCountDown(year, month, day, hours, mins, secs) {
  var now = new Date();
  var endDate = new Date(year, month - 1, day);
  var leftTime = endDate.getTime() - now.getTime();
  var leftsecond = parseInt(leftTime / 1000);
  var day = Math.floor(leftsecond / (60 * 60 * 24));
  var hour = Math.floor((leftsecond - day * 24 * 60 * 60) / 3600);
  var minute = Math.floor((leftsecond - day * 24 * 60 * 60 - hour * 3600) / 60);
  var second = Math.floor(leftsecond - day * 24 * 60 * 60 - hour * 3600 - minute * 60);
  var d1 = "0";
  var d2 = "0";
  var h1 = "0";
  var h2 = "0";
  var m1 = "0";
  var m2 = "0";
  var s1 = "0";
  var s2 = "0";
  if (leftTime > 0) {
    if (day < 10) {
      d2 = day.toString().substr(0, 1);
    } else {
      d1 = day.toString().substr(0, 1);
      d2 = day.toString().substr(1, 1);
    }
    if (hour < 10) {
      h2 = hour.toString().substr(0, 1);
    } else {
      h1 = hour.toString().substr(0, 1);
      h2 = hour.toString().substr(1, 1);
    }
    if (minute < 10) {
      m2 = minute.toString().substr(0, 1);
    } else {
      m1 = minute.toString().substr(0, 1);
      m2 = minute.toString().substr(1, 1);
    }
    if (second < 10) {
      s2 = second.toString().substr(0, 1);
    } else {
      s1 = second.toString().substr(0, 1);
      s2 = second.toString().substr(1, 1);
    }
  }
  $("#d1").html(d1);
  $("#d2").html(d2);
  $("#h1").html(h1);
  $("#h2").html(h2);
  $("#m1").html(m1);
  $("#m2").html(m2);
  $("#s1").html(s1);
  $("#s2").html(s2);
}

function preview_photo(input, index) {
  var MAXWIDTH = 80;
  var MAXHEIGHT = 80;
  if (input.files && input.files[0]) {
    var file = input.files[0]
    console.log( 'in files ')
    var img = document.getElementById('photo' + index);
    img.onload = function() {
      var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
      img.width = rect.width;
      img.height = rect.height;
      img.style.marginTop = rect.top + 'px';
    }
    var reader = new FileReader();
    reader.onload = function(evt) {
      img.src = evt.target.result;
    }
    reader.readAsDataURL(file);


    $("#photodiv" + index).show();
    $("#uploaddiv" + index).hide();
    if ($("#wrapper_div" + index).nextAll(".wrapper_div").length > 0) {
      $("#wrapper_div" + index).nextAll(".wrapper_div").first().children(".weui-uploader__input-box").show();
    }

  }
}

function delete_photo(index) {
  //remove data
  $("#photograph_photos_attributes_" + index + "_photo").val('');
  $("#photodiv" + index).hide();
  if ($("#wrapper_div" + index).nextAll(".wrapper_div").length == 0) {
    $("#uploaddiv" + index).show();
  } else {
    //show upload img
    var next_wrapper = $("#wrapper_div" + index).nextAll(".wrapper_div").first();
    while (next_wrapper.length > 0) {
      if (next_wrapper.children(".weui-uploader__input-box").children(".weui-uploader__input").prop('files').length > 0) {
        next_wrapper = next_wrapper.nextAll(".wrapper_div").first();
      } else {
        next_wrapper.children(".weui-uploader__input-box").show();
        break;
      }
    }
    //move current to the end of outer div
    $("#wrapper_div" + index).appendTo("#photos_div");
  }
}

function delete_editing_photo(index) {
  delete_photo(index);
  if ($("#photograph_photos_attributes_" + index + "_id").length > 0) {
    var photo_id = $("#photograph_photos_attributes_" + index + "_id").val();
    $("#photos_div").prepend("<input id='photograph_photos_attributes_" + (index + 5) + "__destroy' value='true' name='photograph[photos_attributes][" + (index + 5) + "][_destroy]' type='hidden'>");
    $("#photos_div").prepend("<input id='photograph_photos_attributes_" + (index + 5) + "_id' value='" + photo_id + "' name='photograph[photos_attributes][" + (index + 5) + "][id]' type='hidden'>");
    $("#photograph_photos_attributes_" + index + "_id").remove();
    $("#photograph_photos_attributes_" + index + "__destroy").remove();
  }
}

function clacImgZoomParam(maxWidth, maxHeight, width, height) {
  var param = {
    top: 0,
    left: 0,
    width: width,
    height: height
  };
  if (width > maxWidth || height > maxHeight) {
    rateWidth = width / maxWidth;
    rateHeight = height / maxHeight;

    if (rateWidth > rateHeight) {
      param.width = maxWidth;
      param.height = Math.round(height / rateWidth);
    } else {
      param.width = Math.round(width / rateHeight);
      param.height = maxHeight;
    }
  }

  param.left = Math.round((maxWidth - param.width) / 2);
  param.top = Math.round((maxHeight - param.height) / 2);
  return param;
}

//https://segmentfault.com/a/1190000016535556
//对图片旋转处理
function rotateImg(img, direction, canvas) {
  console.log("开始旋转图片");
  //图片旋转4次后回到原方向
  if (img == null) return;
  var height = img.height;
  var width = img.width;
  var step = 2;

  if (direction == "right") {
    step++;
  } else if (direction == "left") {
    step--;
  } else if (direction == "horizen") {
    step = 2; //不处理
  }
  //旋转角度以弧度值为参数
  var degree = step * 90 * Math.PI / 180;
  var ctx = canvas.getContext("2d");
  switch (step) {
    case 0:
      canvas.width = width;
      canvas.height = height;
      ctx.drawImage(img, 0, 0);
      break;
    case 1:
      canvas.width = height;
      canvas.height = width;
      ctx.rotate(degree);
      ctx.drawImage(img, 0, -height);
      break;
    case 2:
      canvas.width = width;
      canvas.height = height;
      ctx.rotate(degree);
      ctx.drawImage(img, -width, -height);
      break;
    case 3:
      canvas.width = height;
      canvas.height = width;
      ctx.rotate(degree);
      ctx.drawImage(img, -width, 0);
      break;
  }
  console.log("结束旋转图片");
}

// const { data } = require("jquery");

$(function(){
  $(".Base__body__area__item__informationArea__space").on('keyup', function(){
    $(".Base__body__area__item__informationArea__number").text($(this).val().length + "/1000");
  });
  
  $("#price").change(function(){
    var price = $("#price").val();
    var priceI = parseInt(price);
    var fee = priceI / 10;
    var profit = priceI - fee
    var feeRadix = parseInt(fee, 10);
    var profitRadix = parseInt(profit, 10);

    $(".Base__body__area__price__chargeArea__calculate").html(feeRadix);
    $(".Base__body__area__price__profitArea__calculate").html(profitRadix);
  });


  const buildFileField = (num)=> {
    const html = `<div id="iconArea-js" data-index="${num}">
                  <label class="Base__body__area__picture__iconArea" for="item_images_attributes_${num}_image_url"><i class="fas fa-camera"></i>
                  <input class="Base__body__area__picture__iconArea__pictureArea" type="file" name="item[images_attributes][${num}][image_url]" id="item_images_attributes_${num}_image_url">
                  </label></div>
                  `;
    return html;
  }

  const buildImg = (index, url)=> {
    const html = `<img data-index="${index}" src="${url}" width="100px" height="80px">
                  <div class="Base__body__area__picture__iconArea__delete">　　　削除</div>
                  `;
    return html;
  }

  let fileIndex = [1,2,3,4,5,6,7,8,9,10];
  lastIndex = $("#iconArea-js.last").data("index");
  fileIndex.splice(0, lastIndex);

  $(".hidden-destroy").hide();
// ---------------削除----------------------------------削除---------------------------------------------
  $("#image-box").on("click", ".Base__body__area__picture__iconArea__delete", function(){
    const targetIndex = $(this).parent().parent().data("index")
    console.log(this)
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    if (hiddenCheck) hiddenCheck.prop("checked, true");

    $(this).prev().remove();
    $(this).remove();
    $(`imag[data-index="${targetIndex}"]`).remove();

    if ($(".Base__body__area__picture__iconArea__pictureArea").length == 0) $("#image-box").append(buildFileField(fileIndex[0]));
  });
// ---------------プレビュー----------------------------------プレビュー---------------------------------------------
  $("#image-box").on("change", ".Base__body__area__picture__iconArea__pictureArea", function(e){
    $(".Base__body__area__picture__iconArea").css({"display":"none"});
    const targetIndex = $(this).parent().parent().data("index");
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    if (img = $(`img[data-index="${targetIndex}"]`)[0]){
      img.setAttribute("image_url", blobUrl);
    } else {
      $("#previews").append(buildImg(targetIndex, blobUrl));
      $("#image-box").append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
    }
  });
})
$(document).on('turbolinks:load', ()=> {
　var cam = Array.from(document.getElementsByClassName('fa-camera'))
  cam.pop()
  cam.forEach(function(cam1){
    $(cam1).hide()
  })
  
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
    const html = `<div class="Preview__wrapper" data-index="${index}"><img data-index="${index}" src="${url}" width="100px" height="80px">
                  <div class="Preview__wrapper__btn"><div class="Preview__wrapper__btn__delete">削除</div><div class="Preview__wrapper__btn__edit">編集</div></div></div>
                  `;
    return html;
  }

  $(".hidden-destroy").hide();
// ---------------削除----------------------------------削除---------------------------------------------
  $("#image-box").on("click", ".Preview__wrapper__btn__delete", function(){
    const targetIndex = $(this).parent().parent().data("index")
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
  
    if(hiddenCheck) hiddenCheck.prop("checked", true);

    $(this).parent().parent().remove();
    $(`imag[data-index="${targetIndex}"]`).remove();

  });
// ---------------プレビュー----------------------------------プレビュー---------------------------------------------
  $("#image-box").on("change", ".Base__body__area__picture__iconArea__pictureArea", function(e){
    const targetIndex = $(this).parent().parent().data("index");
    console.log(targetIndex)
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute("src", blobUrl);
    } else {
      $("#previews").append(buildImg(targetIndex, blobUrl));
      $("#image-box").append(buildFileField(targetIndex + 1));
    };
    $("#item_images_attributes_" + targetIndex + "_image_url").parent().css({"display":"none"});
  });
// ---------------編集----------------------------------編集---------------------------------------------
  $("#image-box").on("click", ".Preview__wrapper__btn__edit", function(e){
    const targetIndex = $(this).parent().parent().data("index");
    $("#item_images_attributes_" + targetIndex + "_image_url").click();
  });
})
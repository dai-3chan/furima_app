document.addEventListener( 'turbolinks:load', function() {
    if (document.getElementById("token_submit") != null) { 
      Payjp.setPublicKey("pk_test_68657d45381cee0b7a369d9f");//公開鍵  
      let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得
      btn.addEventListener("click", e => { //ボタンが押されたときに作動
        e.preventDefault(); //ボタン無効化
        let card = {
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: document.getElementById("exp_year").value
        }; //入力されたデータを取得
        
        Payjp.createToken(card, (status, response) => {
          if (status === 200) { //成功した場合
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name"); //データを自サーバにpostしないよう
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            );
            document.inputForm.submit();
            alert("登録が完了しました"); 
          } else {
            alert("カード情報が正しくありません。"); 
          }
        });
      });
    }
  }
);
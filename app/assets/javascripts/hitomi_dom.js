
//ひとみの柄を変更
function ChangeHitomiColor(object_id,color){
	var file_name;
	if(color == "blue"){
		file_name = "blueFlower.png";
	}
	else if(color == "pink"){
		file_name = "pinkMusicDevil.png";
	}
	else if(color == "black"){
		file_name = "blueMusicWitch.png";
	}
	else if(color == "original"){
		file_name = "grad.png";
	}
	$(object_id).attr("src","/assets/"+file_name);
}



function ShowModal(id){
	//キーボード操作などにより、オーバーレイが多重起動するのを防止する
	$(this).blur() ;	//ボタンからフォーカスを外す
	if($("#modal-overlay")[0]) return false ;		//新しくモーダルウィンドウを起動しない [下とどちらか選択]
	//if($("#modal-overlay")[0]) $("#modal-overlay").remove() ;		//現在のモーダルウィンドウを削除して新しく起動する [上とどちらか選択]

	//オーバーレイ用のHTMLコードを、[body]内の最後に生成する
	$("body").append('<div id="modal-overlay"></div>');

	//[$modal-overlay]をフェードインさせる
	$("#modal-overlay").fadeIn("slow");

	//[$modal-content]をフェードインさせる
	$(id).fadeIn("slow");

	//コンテンツをセンタリングする
	 centeringModalSyncer(id) ;

	$( "#modal-overlay,.modal-close" ).unbind().click( function(){

		//[#modal-content]と[#modal-overlay]をフェードアウトした後に…
		$( id+",#modal-overlay" ).fadeOut( "slow" , function(){

			//[#modal-overlay]を削除する
			$('#modal-overlay').remove() ;

		});
	});
}

function centeringModalSyncer(id){

	//画面(ウィンドウ)の幅を取得し、変数[w]に格納
	var w = $(window).width();

	//画面(ウィンドウ)の高さを取得し、変数[h]に格納
	var h = $(window).height();

	//コンテンツ(#modal-content)の幅を取得し、変数[cw]に格納
	var cw = $(id).outerWidth({margin:true});

	//コンテンツ(#modal-content)の高さを取得し、変数[ch]に格納
	var ch = $(id).outerHeight({margin:true});

	//コンテンツ(#modal-content)を真ん中に配置するのに、左端から何ピクセル離せばいいか？を計算して、変数[pxleft]に格納
	var pxleft = ((w - cw)/2);

	//コンテンツ(#modal-content)を真ん中に配置するのに、上部から何ピクセル離せばいいか？を計算して、変数[pxtop]に格納
	var pxtop = ((h - ch)/2);

	//[#modal-content]のCSSに[left]の値(pxleft)を設定
	$(id).css({"left": pxleft + "px"});

	//[#modal-content]のCSSに[top]の値(pxtop)を設定
	$(id).css({"top": pxtop + "px"});
}

function ModalFadeOut(id){
	//[#modal-content]と[#modal-overlay]をフェードアウトした後に…
	$( id+",#modal-overlay" ).fadeOut( "slow" , function(){
		//[#modal-overlay]を削除する
		$('#modal-overlay').remove() ;
	});
}

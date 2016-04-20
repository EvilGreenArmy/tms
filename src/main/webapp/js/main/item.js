$(document).ready(function(){
      /*$('.teacher_list>li>div').hover(function(){
      	  $(this).css({"border-color":"#D84634","border-width":"2px"});
      	  
      	   $(this).find(".gotoNext").removeClass("gotoNext").addClass("");//.attr("src","${cdn}/images/pc-17.jpg");
      },function(){
      	  $(this).css({"border-color":"#dae1e5","border-width":"2px"});
      	  $(this).find(".gotoNext").attr("src","${cdn}/images/pc-18.jpg");
      });*/
      $('.class_list>li>div').hover(function(){
      	  $(this).css({"border-color":"#D84634","border-width":"2px"});
      	  
      	   $(this).find(".gotoNext").attr("src","${cdn}/images/pc-17.jpg");
      },function(){
      	  $(this).css({"border-color":"#dae1e5","border-width":"2px"});
      	  $(this).find(".gotoNext").attr("src","${cdn}/images/pc-18.jpg");
      });  
               $(".menu_div_select .button").click(function(){		   	    	  
		   	    	  	$(".menu_div_select>ul").show();		   	    	  
		   	    });
		   	    $(".menu_div_select>ul>li>span").click(function(){
		   	    	$(".menu_div_select>span").text($(this).text()); 
		   	    	$(".menu_div_select>ul").hide();
		   	    });
		   	    
					/* 图片滚动效果 *//*资质荣誉*/
					$(".item_content_left_honour .mr_frbox").slide({
						titCell: "",
						mainCell: ".honour_content ul",
						autoPage: true,
						effect: "leftLoop",
						autoPlay: true,
						vis: 1
					});
					/* 图片滚动效果 *//*名师风采*/
					$(".teacher_style .mr_frbox").slide({
						titCell: "",
						mainCell: ".teacher_style_content ul",
						autoPage: true,
						effect: "leftLoop",
						autoPlay: true,
						vis: 5
					});
					/* 图片滚动效果 *//*教学环境*/
					$(".teach_environment .mr_frbox").slide({
						titCell: "",
						mainCell: ".teach_environment_content ul",
						autoPage: true,
						effect: "leftLoop",
						autoPlay: true,
						vis: 4
					});
					/*列表切换*/
					$("#view").click(function(){
						$(this).removeClass("unactive");
						$(this).next().addClass("unactive");
						$(".view_list").show();
						$(".evaluate_list").hide();
					});
					$("#evaluate").click(function(){
						$(this).removeClass("unactive");
						$(this).prev().addClass("unactive");
						$(".view_list").hide();
						$(".evaluate_list").show();
					});
					/*留言板弹出回复*/
					$(".evaluate_list>li").find(".reply_bt").click(function(){
											
					$(this).parents(".evaluate_list>li").find(".message_ipt_div").slideToggle("slow");					
				    });
				    /*机构留言板*/
				    $(".item_content_right .item_div .title>span>a").click(function(){
				    	$(this).siblings().removeClass("active");
				    	$(this).addClass("active");
				    });
				    /*gallery*/
					$(".item_content_right .school_classing .gallery>div>div").hover(function(){
						 $(this).find(".top_div").show();
						 $(this).find(".top_div_p").show();
						 $(this).find(".bottom_div").show();
					},function(){
						$(this).find(".top_div").hide();
						 $(this).find(".top_div_p").hide();
						 $(this).find(".bottom_div").hide();
					});
//					/*在线授课翻页*/
//					 /*初始化宽度*/      
//			          var w = $(".item_content_right .school_classing .gallery>div").children("div").length*216;
//			          var count = 1;
//			          var total = 16;
//			          var curIndex = 4;
//			          $(".item_content_right .school_classing .gallery>div").css("width",w+"px");
//					  $(".gallery_next").click(function(){					  	
//					  	$(".item_content_right .school_classing .gallery>div").animate({right:(count*866)+"px"},"fast");
//					  	count++;
//					  	curIndex+=4;
//					  	if(curIndex>=total){
//					  		$(".gallery_next").hide();
//					  	}
//					  });
//					  $(".gallery_prev").click(function(){		
//					   	if(count>1){count--;};
//					   	  $(".item_content_right .school_classing .gallery>div").animate({right:(count*866-866)+"px"},"fast");
//					   	  curIndex-=4;
//					  	 if(curIndex<=total){
//					  		$(".gallery_next").show();
//					  	}
//					  	  
//					  });
					/*教师风采*/
					$(".item_content_right .teacher_style .teacher_style_content li").hover(function(){
						  $(this).find("p").css({"background":"#D84634","color":"#ffffff"});
					},function(){
						  $(this).find("p").css({"background":"#ffffff","color":"#333333"});
						  $(this).find(".teach_type").css("color","#999999")
					});
					/*猜你喜欢*/
				$(".curriculum_main ul li").find("div").hover(function(){
					$(this).find(".growth_div").stop(true);
					$(this).find(".growth_div").animate({bottom:'40px'},'fast');
				},function(){
				    $(this).find(".growth_div").stop(true);
					$(this).find(".growth_div").animate({bottom:'0px'},'fast');
				});
				/*优惠券*/
				var coupon_clicknum = 0;
				$(".coupon .more").click(function(){
					++coupon_clicknum;
					$(".couponlist").stop().slideToggle("slow");
					if(coupon_clicknum%2==0){
						$(this).html("更多");
					}else{
						$(this).html("收起");
					}
				});
				/*订单详情*/
				var order_clicknum = 0;
				$(".order_detail").click(function(){
					++order_clicknum;
					$(".order_detail_list").stop().slideToggle("slow");
					if(order_clicknum%2==0){
						$(this).html("订单详情");
					}else{
						$(this).html("收起");
					}
					
				});
				/*支付方式*/
				$(".pay_method").find("input").click(function(){
					if($(this).prop("checked")){   //checkbox判断是否被选中用prop();attr无效；
						$(this).parent().css({"border-color":"#D84634"});
						$(this).parent().find(".pay_price").show();
					}else{
						$(this).parent().find(".pay_price").hide();
						$(this).parent().css({"border-color":"#C6C6C6"});
					}
				});
				/*倒计时*/
			    add(); //首次调用add函数
                
			    /*列表页认证*/              
               $("#teachers>li>div").find(".shiming").hover(function(){
               	     //console.log($(this).parents("#teachers>li>div"));
               	    $(this).parents("#teachers>li>div").find(".shiming_authentication").show();
               },function(){
                 	 $(this).parents("#teachers>li>div").find(".shiming_authentication").hide();
               });
              
               $("#teachers>li>div").find(".xueli").hover(function(){
            	   $(this).parents("#teachers>li>div").find(".xueli_authentication").show();
               },function(){
            	   $(this).parents("#teachers>li>div").find(".xueli_authentication").hide();
               });
               $("#teachers>li>div").find(".zizhi").hover(function(){
            	   $(this).parents("#teachers>li>div").find(".zizhi_authentication").show();
               },function(){
            	   $(this).parents("#teachers>li>div").find(".zizhi_authentication").hide();
               });

				$(".jigoulink").hover(function(){
					$(this).css("color","#D84634");
				},function(){
					$(this).css("color","#333333");
				});
               $("#titleLength").css('left',(parseFloat($(".line").css("width"))-parseFloat($("#titleLength").css("width")))/2+"px");
            });
          /*倒计时*/
           var timerc=1800; //全局时间变量（秒数）
           function add(){ //加时函数
			        if(timerc > 0 ){ //如果不到5分钟
			            --timerc; //时间变量自增1
			            $(".min").html(parseInt(timerc/60)); //写入分钟数
			            $(".sec").html(Number(parseInt(timerc%60/10)).toString()+(timerc%10)); //写入秒数（两位）
			            setTimeout("add()", 1000); //设置1000毫秒以后执行一次本函数
			        };
			    };
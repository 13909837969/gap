function gbl_open_fullscreen(element){
	if(element.requestFullscreen){
		//if(document.isFullScreen==false){
			element.requestFullscreen();
		//}
	}else if(element.mozRequestFullScreen){
		//if(document.mozIsFullScreen==false){
			element.mozRequestFullScreen();
		//}
	}else if(element.webkitRequestFullscreen){
		//if(document.webkitIsFullScreen==false){
			element.webkitRequestFullscreen();
		//}
	}else if(element.msRequestFullscreen){
		//if(document.msIsFullScreen==false){
			element.msRequestFullscreen();
		//}
	}
}
//gbl_open_fullscreen(document.documentElement);
function gbl_exit_fullscreen() {
	  if(document.exitFullscreen) {
	    document.exitFullscreen();
	  } else if(document.mozCancelFullScreen) {
	    document.mozCancelFullScreen();
	  } else if(document.webkitExitFullscreen) {
	    document.webkitExitFullscreen();
	  }
}
window.onclick=function(){
	gbl_open_fullscreen(document.documentElement);
}
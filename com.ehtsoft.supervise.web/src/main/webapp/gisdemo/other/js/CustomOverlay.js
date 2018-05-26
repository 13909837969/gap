
//自定义覆盖物

/*
function ComplexCustomOverlay(point, text, mouseoverText,id)
{
      this._point = point;
      this._text = text;
      this._overText = mouseoverText;
      this._id = id;
}
*/

function CreateCustomOverlay()
{
    ComplexCustomOverlay.prototype = new BMap.Overlay();
    
    ComplexCustomOverlay.prototype.initialize = function(map){
      this._map = map;
      var div = this._div = document.createElement("div");
      div.style.position = "absolute";
      div.style.zIndex = BMap.Overlay.getZIndex(this._point.lat);
      
      div.style.border = "1px solid #0452b2";      
      div.style.background = "url(/images/bg_blue.png) repeat-x";
      
      //div.style.backgroundColor = "#EE5D5B";
      //div.style.border = "1px solid #0452b2";
      //div.style.background = "url(/img/blue.png) no-repeat";
      div.style.color = "white";
      div.style.height = "26px";
      div.style.lineHeight = "26px";
      //div.style.width = "118px";
      
      //div.style.padding = "auto";
      div.style.paddingLeft = "5px";
      div.style.paddingRight = "5px";
      div.style.whiteSpace = "nowrap";
      div.style.MozUserSelect = "none";
      div.style.fontSize = "12px"
      var span = this._span = document.createElement("span");
      div.appendChild(span);
      span.appendChild(document.createTextNode(this._text));      
      var that = this;

      var arrow = this._arrow = document.createElement("div");
      arrow.style.background = "url(/images/blue_arrow.png) no-repeat";
      arrow.style.position = "absolute";
      arrow.style.width = "19px";
      arrow.style.height = "12px";
      arrow.style.top = "27px";
      arrow.style.left = "5px";
      arrow.style.overflow = "hidden";
      div.appendChild(arrow);
     
      div.onmouseover = function(){
        div.style.background = "url(/images/bg_yellow.png) repeat-x";
        this.style.borderColor = "#b04c01";
        
        //div.style.background = "url(/img/yellow.png) no-repeat";
        //this.style.backgroundColor = "#6BADCA";
        //this.style.borderColor = "#0000ff";
        this.getElementsByTagName("span")[0].innerHTML = that._overText;
        //arrow.style.backgroundPosition = "0px -20px";
        arrow.style.background = "url(/images/yellow_arrow.png) no-repeat";
      }

      div.onmouseout = function(){
        div.style.background = "url(/images/bg_blue.png) repeat-x";
        this.style.borderColor = "#0452b2";
        
        //div.style.background = "url(/img/blue.png) no-repeat";
        //this.style.backgroundColor = "#EE5D5B";
        //this.style.borderColor = "#BC3B3A";
        this.getElementsByTagName("span")[0].innerHTML = that._text;
        //arrow.style.backgroundPosition = "0px 0px";
        arrow.style.background = "url(/images/blue_arrow.png) no-repeat";
      }
      
      div.onclick = function()
      {
        OverlayClick(that._id);
      }

      map.getPanes().labelPane.appendChild(div);
      
      return div;
    }
    ComplexCustomOverlay.prototype.draw = function(){
      var map = this._map;
      var pixel = map.pointToOverlayPixel(this._point);
      this._div.style.left = pixel.x - parseInt(this._arrow.style.left) + "px";
      this._div.style.top  = pixel.y - 30 + "px";
    }
    
}
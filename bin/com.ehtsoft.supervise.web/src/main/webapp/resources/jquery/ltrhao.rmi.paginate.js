/**
 * 翻页对象
 * @returns {Eht.Paginate}
 * @author wangbao
 */
Eht.Paginate=function(){
	this.indexPage = 1;
	this.totalCount = 0;
	this.pageCount = 10;
	
	this.getTotalPage=function(){
		if(this.pageCount==0){
			this.pageCount = 20;
		}
		total = Math.ceil(this.totalCount / this.pageCount);
		return total;
	};
	this.getAbsolute=function(){
		return this.pageCount * (this.indexPage-1) + 1;
	};
	this.getFirstPage=function(){
		this.indexPage = 1;
		return this.indexPage;
	};
	this.getEndPage=function(){
		this.indexPage = this.getTotalPage();
		return this.indexPage;
	};
	this.getNextPage=function(){
		if(this.indexPage<this.getTotalPage()){
			this.indexPage ++;
		}
		return this.indexPage;
	};
	this.getPrevPage=function(){
		if(this.indexPage>1){
			this.indexPage--;
		}
		return this.indexPage;
	};
};
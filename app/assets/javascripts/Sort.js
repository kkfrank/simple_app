function SortHelper(){
    this.arr=[]
}
SortHelper.prototype={
    constructor:SortHelper,
    create:function(n){
        for(var i=0;i<n;i++){
            this.arr.push(i)
        }
        return this.arr
    },
    change:function(i,j){
        var temp=this.arr[i]
        this.arr[i]=this.arr[j]
        this.arr[j]=temp
    },
    random:function(){
        var n=this.arr.length;
        for(var i=n-1;i>0;i--){//从最后一个开始，从他和他之前的数任取一个，和他本身交换
            var rdn=parseInt(Math.random()*(i+1))
            this.change(i,rdn)
        }
        return this.arr
    },
    log:function(){
      console.log(this.arr)
    },
    quickSort:function(){
        this._quickSort(this.arr,0,this.arr.length-1)
    },
    _quickSort:function(arr,lo,hi){
        if(lo>=hi){
            return
        }
        var j=this.partition(arr,lo,hi)
        this._quickSort(arr,lo,j-1)
        this._quickSort(arr,j+1,hi)
    },
    partition:function(arr,lo,hi){
        var temp=lo,i=lo,j=hi+1
        while(true){
            while(arr[++i]<arr[temp]) {if(i>hi) break}
            while(arr[--j]>arr[temp]) {if(j<lo) break}

            if(i>=j){
                break
            }else{
                this.change(i,j)
            }
        }
        this.change(temp,j)
        return j
    }
}
var helper=new SortHelper()
helper.create(2)
helper.random()
helper.quickSort()
helper.log()
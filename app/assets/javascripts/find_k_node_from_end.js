function ListNode(val){
    this.val=val;
    this.next=null;
}

function ListNodeHelper(){
    this.head=null
}
ListNodeHelper.prototype={
    constructor:ListNode,
    create:function(n){
        var p=null
        for(var i=0;i<n;i++){
            if(!this.head){
                this.head=p=new ListNode(i)
            }else{
                p.next=new ListNode(i)
                p=p.next
            }
        }
        return this.head
    },
    log:function(){
        var res=[],p=this.head
        while(p){
            res.push(p.val)
            p=p.next
        }
        return res
    },
    findKFromEnd:function(k){
        if(k<=0 || !this.head){
            return null
        }
        var ahead=this.head,bhead=this.head
        for(var i=0;i<k-1;i++){//一个指针先走k-1步，然后一起走，前面的指针走到最后，停止
            ahead=ahead.next;
            if(!ahead){
                return null
            }
        }
        while(ahead.next){
            ahead=ahead.next
            bhead=bhead.next
        }
        return bhead
    }
}
var helper=new ListNodeHelper()
helper.create(5)
console.log(helper.findKFromEnd(2))

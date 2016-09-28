# 知乎日报

---
##实现

* 实现进入知乎日报时用TableView显示知乎日报的热门。
* 加入了多行显示功能，会好看一些。
* 点击主界面的Cell可以跳转详细信息了
* 又用了webview显示详细信息（以前是textview
* 现在详细信息中图与文字可以自适应了。。
* 增加了启动界面
---
##问题

* 详细信息里面的图片不能随webview的滑动而滑动，亲测手写（非storyboard用```[webview.scrollview addsubview:imageview]```可以解决

---
##想法
* 做一个上下滑动查看更多和隐藏navigation bar的功能
* 想做一个不是纯TableView的主界面。
* 想实现点击TextView里面图片查看原图的功能
* 做一个侧拉框

#####beta1
#####持续更新中……
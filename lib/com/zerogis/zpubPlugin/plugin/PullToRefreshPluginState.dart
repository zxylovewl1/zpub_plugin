import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:zpub_bas/zpub_bas.dart';

/*
 * 类描述：下拉上拉刷新基类
 * 作者：郑朝军 on 2019/5/22
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/5/22
 * 修改备注：
 */
abstract class PullToRefreshPluginState<T extends StatefulWidget> extends FuctionStateBase<T>
{
  GlobalKey<EasyRefreshState> mRefreshKey = new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> mHeaderKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> mFooterKey = new GlobalKey<RefreshFooterState>();

  /*
   * 正在加载文字
   */
  String mLoadingText = "正在加载...";

  /*
   * 创建内容栏
   */
  Widget buildBodyWithRefresh(BuildContext context, Widget body)
  {
    return super.buildBody(context, createCommonRefresh(body));
  }

  /*
   * 创建下拉刷新组件<br/>
   * @param body 下拉刷新内容
   */
  Widget createCommonRefresh(Widget body)
  {
    return new EasyRefresh(
      key: mRefreshKey,
      refreshHeader: ClassicsHeader(
        key: mHeaderKey,
        refreshText: "下拉刷新",
        refreshReadyText: "释放刷新",
        refreshingText: "释放刷新...",
        refreshedText: "刷新结束",
        moreInfo: "更新于 %T",
        bgColor: Colors.transparent,
        textColor: ColorRes.text_color_text1,
        moreInfoColor: Colors.black54,
        showMore: true,
      ),
      refreshFooter: ClassicsFooter(
        key: mFooterKey,
        loadText: "上拉加载",
        loadReadyText: "释放加载",
        loadingText: mLoadingText,
        noMoreText: "加载结束",
        moreInfo: "更新于 %T",
        bgColor: Colors.transparent,
        textColor: ColorRes.text_color_text1,
        moreInfoColor: Colors.black54,
        showMore: true,
      ),
      onRefresh: useRefresh() ? onRefresh : null,
      loadMore: useLoadMore() ? loadMore : null,
      child: body,
    );
  }

  /*
   * 是否启用下拉刷新默认启用
   */
  bool useRefresh()
  {
    return true;
  }

  /*
   * 是否启用上拉加载更多默认启用
   */
  bool useLoadMore()
  {
    return true;
  }

  /*
   * 下拉刷新
   */
  Future<void> onRefresh()
  {}

  /*
   * 上拉加载更多
   */
  Future<void> loadMore()
  {}
}

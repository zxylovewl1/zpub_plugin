import 'package:flutter/foundation.dart';
import 'package:zpub_plugin/zpub_plugin.dart';

/*
 * 类描述：组件基类
 * 作者：郑朝军 on 2019/6/10
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/6/10
 * 修改备注：
 */
abstract class WidgetStatefulBase extends PluginStatefulBase
{
  WidgetStatefulBase({Key key, plugin}) : super(key: key, plugin: plugin);
}

/*
 * 页面功能 <br/>
 */
abstract class WidgetBaseState<T extends WidgetStatefulBase>
    extends PluginBaseState<T>
{
  /*
   * 是否使用入栈操作
   */
  bool usePushStack()
  {
    return false;
  }

  /*
   * 构造方法
   */
  WidgetBaseState()
  {}

  /*
   * 初始化相关
   */
  void init()
  {
    initView();
    initData();
    initListener();
  }

  /*
   * 初始化视图相关
   */
  void initView()
  {
  }

  /*
   * 初始化数据相关
   */
  void initData()
  {
    queryInitPara();
    queryInitParaPlugins();
    queryWidgetsList();
  }

  /*
   * 初始化监听相关
   */
  void initListener()
  {
  }
}
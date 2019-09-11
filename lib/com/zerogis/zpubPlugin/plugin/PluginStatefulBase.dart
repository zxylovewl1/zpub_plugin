import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/constant/DigitValueConstant.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/constant/MapKeyConstant.dart';
import 'package:zpub_bas/com/zerogis/zpubbase/constant/StringValueConstant.dart';
import 'package:zpub_bas/zpub_bas.dart';
import 'package:zpub_dbmanager/com/zerogis/zpubDbManager/bean/Plugin.dart';
import 'package:zpub_dbmanager/com/zerogis/zpubDbManager/method/InitSvrMethod.dart';
import 'package:zpub_plugin/com/zerogis/zpubPlugin/constant/InitParamKeyConstant.dart';
import 'package:zpub_plugin/com/zerogis/zpubPlugin/font/IconFont.dart';
import 'package:zpub_plugin/com/zerogis/zpubPlugin/util/ParamInitUtil.dart';

import 'PullToRefreshPluginState.dart';

/*
 * 插件基类 <br/>
 * plugin对象可以传，可以不传
 * 需要传入的键：<br/>
 * 传入的值类型： <br/>
 * 传入的值含义：<br/>
 * 是否必传 ：
 */
abstract class PluginStatefulBase extends StatefulWidget
{
  /*
   * 插件表中对应子插件的一条数据
   */
  Plugin plugin;

  PluginStatefulBase({Key key, @required this.plugin}) : super(key: key)
  {
    if (plugin == null)
    {
      List<Plugin> list = InitSvrMethod.getInitSvrPlugins();
      Iterator<Plugin> iterator = list.iterator;
      while (iterator.moveNext())
      {
        if (iterator.current.classurl == runtimeType.toString())
        {
          this.plugin = iterator.current;
          break;
        }
      }
    }
  }
}

/*
 * 页面功能 <br/>
 */
abstract class PluginBaseState<T extends PluginStatefulBase> extends PullToRefreshPluginState<T>
{
  /*
   * 组件名称
   */
  List<dynamic> mWidgetNameList = <dynamic>[];

  /*
   * 初始化参数
   */
  Map<String, dynamic> mInitParaMap = {};

  /*
   * initpara插件集合
   */
  List<dynamic> mPlugins = <dynamic>[];

  /*
   * 当前属性所有的组件
   */
  Map<GlobalKey<State<StatefulWidget>>, Widget> mChildrenItem = {};

  /*
   * 通用参数孩子组件的或者下一个组件的初始化参数
   */
  Map<String, dynamic> mChildUniversalInitPara = {};

  /*
   * 参数初始化工具类
   */
  ParamInitUtil mParamInitUtil = new ParamInitUtil();

  /*
   * 是否使用入栈操作插件默认入栈
   */
  bool usePushStack()
  {
    if (CxTextUtil.isEmptyMap(mInitParaMap))
    {
      return super.usePushStack();
    }
    else
    {
      return mInitParaMap[
      InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_PUSH_STACK] ==
          DigitValueConstant.APP_DIGIT_VALUE_0
          ? false
          : true;
    }
  }

  /*
   * 是否启用下拉刷新默认启用
   */
  bool useRefresh()
  {
    if (CxTextUtil.isEmptyMap(mInitParaMap))
    {
      return super.useRefresh();
    }
    else
    {
      return mInitParaMap[
      InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_REFRESH] ==
          DigitValueConstant.APP_DIGIT_VALUE_0
          ? false
          : true;
    }
  }

  /*
   * 是否启用上拉加载更多默认启用
   */
  bool useLoadMore()
  {
    if (CxTextUtil.isEmptyMap(mInitParaMap))
    {
      return super.useLoadMore();
    }
    else
    {
      return mInitParaMap[
      InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_LOADMORE] ==
          DigitValueConstant.APP_DIGIT_VALUE_0
          ? false
          : true;
    }
  }

  /*
   * 构造方法
   */
  PluginBaseState()
  {}

  void initState()
  {
    super.initState();
    init();
  }

  Widget build(BuildContext context)
  {
    Widget body;
    if (widget.plugin.getUitype() == DigitValueConstant.APP_DIGIT_VALUE_1)
    {
      body = createWidgetsListView(context);
    }
    else if (widget.plugin.getUitype() ==
        DigitValueConstant.APP_DIGIT_VALUE_2)
    {
      body = createWidgetsCardListView(context);
    }
    else if (widget.plugin.getUitype() ==
        DigitValueConstant.APP_DIGIT_VALUE_3)
    {
      body = createWidgetsRefresh(context);
    }
    return buildBody(context, body);
  }

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
    if (!CxTextUtil.isEmpty(widget.plugin.getIcon()))
    {
      // 设置左边按钮
      setLeadingButtonFromIcon(
          new IconData(int.parse(widget.plugin.getIcon()),
              fontFamily: IconFont.getFamily()));
    }
    if (!CxTextUtil.isEmpty(widget.plugin.getTitlec()) && CxTextUtil.isEmpty(mTitle))
    {
      mTitle = widget.plugin.getTitlec();
    }
  }

  /*
   * 初始化数据相关
   */
  void initData()
  {
    queryInitPara();
    queryInitParaPlugins();
    queryWidgetsList();
    initTitleProgressBar();
  }

  /*
   * 初始化监听相关
   */
  void initListener()
  {
  }

  /*
   * 初始化组件参数名称
   */
  void queryWidgetsList()
  {
    String widgets = widget.plugin.getWidgets();
    if (!CxTextUtil.isEmpty(widgets))
    {
      mWidgetNameList = json.decode(widgets);
    }
  }

  /*
   * 初始化参数
   */
  void queryInitPara()
  {
    String initPara = widget.plugin.getInitpara();
    if (!CxTextUtil.isEmpty(initPara))
    {
      mInitParaMap = json.decode(initPara);
    }
  }

  /*
   * 初始化插件参数
   */
  void queryInitParaPlugins()
  {
    if (!CxTextUtil.isEmptyMap(mInitParaMap))
    {
      mPlugins =
      mInitParaMap[InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_PLUGS];
    }
  }

  /*
   * 初始化titleBar和ProgressBar相关
   */
  void initTitleProgressBar()
  {
    if (CxTextUtil.isEmptyMap(mInitParaMap))
    {
      return;
    }

    int navigationBar = mInitParaMap[
    InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_NAVIGATION_BAR];
    if (navigationBar == DigitValueConstant.APP_DIGIT_VALUE_1)
    {
      // 插件是否显示底部导航栏[1=是,0=否]
      mShowNavigationBar = true;
    }
    int showProgress = mInitParaMap[
    InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_SHOW_PROGRESS];
    if (showProgress == DigitValueConstant.APP_DIGIT_VALUE_1)
    {
      // 插件是否显示进度条[1=是,0=否]
      resetProgressBar(
          text: mInitParaMap[InitParamKeyConstant
              .PLUGIN_INIT_PARAM_KEY_PROGRESS_BAR_TEXT]);
    }
    int titleBar =
    mInitParaMap[InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_TITLE_BAR];
    if (titleBar == DigitValueConstant.APP_DIGIT_VALUE_1)
    {
      // 是否隐藏标题栏[1=是,0=否]
      hideTitleBar();
    }

    int hideBackBtn =
    mInitParaMap[InitParamKeyConstant
        .PLUGIN_INIT_PARAM_KEY_HIDE_BACK_BTN];
    if (hideBackBtn == DigitValueConstant.APP_DIGIT_VALUE_1)
    {
      // 是否隐藏标题栏的返回按钮[1=是,0=否]
      hideBackButton();
    }

    String rightButtonIcon = mInitParaMap[
    InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_RIGHT_BUTTON_ICON];
    String rightButtonText = mInitParaMap[
    InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_RIGHT_BUTTON_TEXT];
    if (!CxTextUtil.isEmpty(rightButtonIcon))
    {
      // 插件中右边按钮图标
      setRightButtonFromIcon(new IconData(int.parse(rightButtonIcon),
          fontFamily: IconFont.getFamily()));
    }
    else if (!CxTextUtil.isEmpty(rightButtonText))
    {
      // 插件中右边文本
      setRightButtonFromText(rightButtonText);
    }

    String borderButtonIcon = mInitParaMap[
    InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_BORDER_BUTTON_ICON];
    String borderButtonText = mInitParaMap[
    InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_BORDER_BUTTON_TEXT];
    if (!CxTextUtil.isEmpty(borderButtonIcon))
    {
      // 插件中侧边按钮图标
      setRightButtonFromIcon(new IconData(int.parse(borderButtonIcon),
          fontFamily: IconFont.getFamily()));
    }
    else if (!CxTextUtil.isEmpty(borderButtonText))
    {
      // 插件中侧边文本
      setRightButtonFromText(borderButtonText);
    }

    String contentBackground = mInitParaMap[
    InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_CONTENT_BACKGROUND];
    if (!CxTextUtil.isEmpty(borderButtonText))
    {
      // 设置内容背景颜色
      List<String> list =
      contentBackground.split(StringValueConstant.STR_COMMON_COMMA);
      setContentBackgroundARGB(
          int.parse(list[DigitValueConstant.APP_DIGIT_VALUE_0]),
          int.parse(list[DigitValueConstant.APP_DIGIT_VALUE_1]),
          int.parse(list[DigitValueConstant.APP_DIGIT_VALUE_2]),
          int.parse(list[DigitValueConstant.APP_DIGIT_VALUE_3]));
    }

    String titleBarBg = mInitParaMap[
    InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_TITLE_BAR_BG];
    if (!CxTextUtil.isEmpty(titleBarBg))
    {
      // 设置标题栏背景颜色
      List<String> list =
      contentBackground.split(StringValueConstant.STR_COMMON_COMMA);
      setTitleBarGgARGB(
          int.parse(list[DigitValueConstant.APP_DIGIT_VALUE_0]),
          int.parse(list[DigitValueConstant.APP_DIGIT_VALUE_1]),
          int.parse(list[DigitValueConstant.APP_DIGIT_VALUE_2]),
          int.parse(list[DigitValueConstant.APP_DIGIT_VALUE_3]));
    }

    Map<String, dynamic> pluginitpara = mInitParaMap[
    InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_PLUG_INITPARA];
    if (!CxTextUtil.isEmptyMap(pluginitpara))
    {
      // 设置配置孩子组件,插件初始化参数到内存中
      mChildUniversalInitPara.addAll(pluginitpara);
    }
  }

  /*
   * 创建listview组件
   */
  Widget createWidgetsListView(BuildContext context)
  {
    return new ListView(children: createChildrenWidget());
  }

  /*
   * 创建listview带有卡片组件
   */
  Widget createWidgetsCardListView(BuildContext context)
  {
    return new Card(child: new ListView(children: createChildrenWidget()));
  }

  /*
   * 创建下拉刷新带有listview组件
   */
  Widget createWidgetsRefresh(BuildContext context)
  {
    return buildBodyWithRefresh(
        context,
        new ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: createChildrenWidget()));
  }

  /*
   * 创建孩子组件集合的条目
   */
  List<Widget> createChildrenWidget()
  {
    List<Widget> list = <Widget>[];
    mWidgetNameList.forEach((widgetName)
    {
      list.add(WidgetsFactory.getInstance().get(widgetName).runWidget(
          initPara: mParamInitUtil.isEmptyMap()
              ? mChildUniversalInitPara
              : mParamInitUtil.getChildNextInitPara(widgetName)));
    });
    return list;
  }

  /*
   * 创建孩子组件集合的条目
   */
  List<Widget> createChildrenKeyWidget()
  {
    mChildrenItem.clear();
    mWidgetNameList.forEach((widgetName)
    {
      GlobalKey key = new GlobalKey<State<StatefulWidget>>();
      dynamic initPara = null;
      if (mParamInitUtil.isEmptyMap())
      {
        mChildUniversalInitPara[MapKeyConstant.MAP_KEY_GLOBAL_KEY] = key;
        initPara = mChildUniversalInitPara;
      }
      else
      {
        initPara = mParamInitUtil.getChildNextInitPara(widgetName);
        initPara[MapKeyConstant.MAP_KEY_GLOBAL_KEY] = key;
      }
      mChildrenItem[key] =
          WidgetsFactory.getInstance().get(widgetName).runWidget(
              initPara: initPara);
    });
    return mChildrenItem.values.toList();
  }


  /*
   * 启动初始化参数中的插件
   * @param index 对应插件的位置
   */
  Future<T> runPlugin<T extends Object>(int index)
  {
    String pluginName = (mPlugins[index] as Map) [MapKeyConstant.MAP_KEY_NAME];
    return PluginsFactory.getInstance().get(pluginName).runPlugin(
        this, initPara: mParamInitUtil.isEmptyMap()
        ? mChildUniversalInitPara
        : mParamInitUtil.getChildNextInitPara(pluginName));
  }

  /*
   * 启动初始化参数中的插件
   * @param pluginName 插件名称
   */
  Future<T> runPluginName<T extends Object>(String pluginName)
  {
    return PluginsFactory.getInstance().get(pluginName).runPlugin(
        this, initPara: mParamInitUtil.isEmptyMap()
        ? mChildUniversalInitPara
        : mParamInitUtil.getChildNextInitPara(pluginName));
  }

  /*
   * 启动初始化参数中的插件模态对话框
   */
  Future<T> runPluginModel<T extends Object>(Object valueChangedMethod)
  {
    Map<String, Object> map = mInitParaMap[InitParamKeyConstant
        .PLUGIN_INIT_PARAM_KEY_PLUG_MODEL];
    mChildUniversalInitPara[MapKeyConstant.MAP_KEY_VALUE_CHANGE_METHOD] =
        valueChangedMethod;
    return showDialog<T>(
        context: context,
        child: new SimpleDialog(
          title: new Text(map[MapKeyConstant.MAP_KEY_VALUE_TITLE]),
          children: <Widget>[
            WidgetsFactory.getInstance()
                .get(map[MapKeyConstant.MAP_KEY_WIDGET])
                .runWidget(
                initPara: mChildUniversalInitPara),
          ],
        ));
  }

  /*
   * 加入孩子通用初始化参数中：启动孩子组件，插件的时候会将参数带入进去给孩子组件，插件
   * @param key 键
   * @param value 值
   */
  void putChildParaInit(String key, dynamic value)
  {
    mChildUniversalInitPara[key] = value;
  }

  /*
   * 根据数据库的配置构造孩子组件需要哪些参数：将填充进来的参数转换成 孩子组件，插件需要的Map集合
   */
  void convertMap()
  {
    if (!CxTextUtil.isEmptyMap(mInitParaMap) &&
        !CxTextUtil.isEmptyMap(mChildUniversalInitPara))
    {
      if (!CxTextUtil.isEmptyMap(mInitParaMap[
      InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_CHILD_INITPARA]))
      {
        mParamInitUtil.convertMap(mInitParaMap, mChildUniversalInitPara);
      }
      else
      {
        showToast(
            InitParamKeyConstant.PLUGIN_INIT_PARAM_KEY_CHILD_INITPARA);
      }
    }
  }
}

/*
 * 类描述：插件初始化key相关参数常量
 * 作者：郑朝军 on 2019/6/5
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/6/5
 * 修改备注：
 */
class PluginInitParamKeyConstant
{
  /*
   * 插件是否入栈操作[1=是,0=否]
   */
  static final String PLUGIN_INIT_PARAM_KEY_PUSH_STACK = "pushStack";

  /*
   * 插件是否显示底部导航栏[1=是,0=否]
   */
  static final String PLUGIN_INIT_PARAM_KEY_NAVIGATION_BAR = "showNavigationBar";

  /*
   * 插件是否显示进度条[1=是,0=否]
   */
  static final String PLUGIN_INIT_PARAM_KEY_SHOW_PROGRESS = "showProgress";

  /*
   * 插件是否显示进度条的文本
   */
  static final String PLUGIN_INIT_PARAM_KEY_PROGRESS_BAR_TEXT = "progressBarText";

  /*
   * 是否隐藏标题栏[1=是,0=否]
   */
  static final String PLUGIN_INIT_PARAM_KEY_TITLE_BAR = "titleBar";

  /*
   * 是否隐藏标题栏的返回按钮[1=是,0=否]
   */
  static final String PLUGIN_INIT_PARAM_KEY_HIDE_BACK_BTN = "hideBackButton";

  /*
   * 插件中右边按钮图标
   */
  static final String PLUGIN_INIT_PARAM_KEY_RIGHT_BUTTON_ICON = "rightButtonIcon";

  /*
   * 插件中右边按钮文本
   */
  static final String PLUGIN_INIT_PARAM_KEY_RIGHT_BUTTON_TEXT = "rightButtonText";

  /*
   * 插件中侧边按钮图标
   */
  static final String PLUGIN_INIT_PARAM_KEY_BORDER_BUTTON_ICON = "borderButtonIcon";

  /*
   * 插件中侧边按钮文本
   */
  static final String PLUGIN_INIT_PARAM_KEY_BORDER_BUTTON_TEXT = "borderButtonText";

  /*
   * 插件中内容背景颜色contentBackground=255,255,255,255
   */
  static final String PLUGIN_INIT_PARAM_KEY_CONTENT_BACKGROUND = "contentBackground";

  /*
   * 插件中标题栏背景颜色contentBackground=255,255,255,255
   */
  static final String PLUGIN_INIT_PARAM_KEY_TITLE_BAR_BG = "titleBarBg";


  /*
   * 是否启用下拉刷新默认值为0[1=启用,0=不启用]
   */
  static final String PLUGIN_INIT_PARAM_KEY_REFRESH = "refresh";

  /*
   * 是否启用上拉加载更多默认值为0[1=启用,0=不启用]
   */
  static final String PLUGIN_INIT_PARAM_KEY_LOADMORE = "loadMore";

  /*
   * 插件key的配置
   */
  static final String PLUGIN_INIT_PARAM_KEY_PLUGS = "plugs";

  /*
   * 孩子(插件,组件)初始化参数:带有？号的参数举例：{"childinitpara":{"major":?,"minor":?,"id":?}}
   */
  static final String PLUGIN_INIT_PARAM_KEY_CHILD_INITPARA = "childinitpara";

  /*
   * 孩子(插件,组件)初始化参数:具体的值举例：{"pluginitpara":{"major":98,"minor":46,"id":-1}}
   */
  static final String PLUGIN_INIT_PARAM_KEY_PLUG_INITPARA = "pluginitpara";

  /*
   * 孩子(模态对话框插件)初始化参数:具体的值举例：{"plugmodel":{"title":"选择部门","widget":"OrganTreeWidget"}}
   */
  static final String PLUGIN_INIT_PARAM_KEY_PLUG_MODEL = "plugmodel";

  /*
   * ---------------------通用组件，插件业务相关-----------------------------------
   */
  static final String PLUGIN_FLDVALUE_DISPTYPE_9 = "plugin";
  /*
   * ---------------------表格组件通用业务相关---------------------------------
   */
  /*
   * 表格每一列的宽度
   */
  static final String PLUGIN_INIT_PARAM_MAIN_KEY_COLUMN_WIDTHS = "columnWidths";
  /*
   * 表格头
   */
  static final String PLUGIN_INIT_PARAM_MAIN_KEY_TABLE_HEAD = "tableHead";
  /*
   * 表格的名称
   */
  static final String PLUGIN_INIT_PARAM_MAIN_KEY_TABLE_NAME = "tableName";


  /*
   * ---------------------业务相关-----------------------------------------------
   */
  /*
   * ---------------------MainPlugin-------------------------------------------
   */
  /*
   * 底部导航拦图标和文本
   */
  static final String PLUGIN_INIT_PARAM_MAIN_KEY_BOTTOM_ICON_TEXT = "bottomIconText";
  static final String PLUGIN_INIT_PARAM_MAIN_KEY_CURRENT_INDEX = "currentIndex";
  static final String PLUGIN_INIT_PARAM_MAIN_KEY_IMAGE_URL = "imageUrl";
}

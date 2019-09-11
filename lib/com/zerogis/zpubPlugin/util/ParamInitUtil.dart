import 'dart:convert';

import 'package:zpub_bas/com/zerogis/zpubbase/constant/StringValueConstant.dart';
import 'package:zpub_bas/zpub_bas.dart';

/*
 * 类描述：参数初始化工具类 数据库的配置推荐使用{"key":"?,[{组件(插件)名称,初始化参数的key}]","key":"?,[{组件(插件)名称,初始化参数的key}]"}
 * 作者：郑朝军 on 2019/6/17
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/6/17
 * 修改备注：
 */
class ParamInitUtil
{
  /*
   * 孩子组件的或者下一个组件的初始化参数
   * Map<String> 插件名称
   * Map<Map<String>> 插件对应的key
   */
  Map<String, Map<String, dynamic>> mChildNextInitPara = {};

  /*
   * 将填充进来的参数转换成孩子组件，插件需要的Map集合
   * @param mapValue 数据库配置的值
   * @param childUniversalInitPara 孩子初始化参数通用值内存中
   */
  void convertMap(Map<String, dynamic> mapValue,
      Map<String, dynamic> childUniversalInitPara)
  {
    Map<String, dynamic> mapJsons = json.decode(
        json.encode(childUniversalInitPara));
    childParaInit(mapValue, mapJsons);
  }

  /*
   * 孩子的参数初始化
   * @param mapValue 数据库配置的值
   * @param mapJsons 内存中的值
   */
  void childParaInit(Map<String, dynamic> mapValue,
      Map<String, dynamic> mapJsons)
  {
    mapValue.forEach((key, value)
    {
      if (value is String &&
          value.contains(StringValueConstant.STR_COMMON_QUESTION))
      {
        convertChildNextInitPara(value, mapJsons[key]);
      }
      else if (value is Map)
      {
        childParaInit(value, mapJsons[key]);
      }
      else if (value is List)
      {
        recursionList(value, mapJsons[key]);
      }
    });
  }


  /*
   * 孩子的参数初始化
   * @param mapValue 数据库配置的值
   * @param mapJsons 内存中的值
   */
  void childParaInitOld(Map<String, dynamic> mapValue,
      Map<String, dynamic> mapJsons)
  {
    mapValue.forEach((key, value)
    {
      if (value == "?")
      {
        print(mapJsons[key]);
      }
      else if (value is Map)
      {
        childParaInit(value, mapJsons[key]);
      }
      else if (value is List)
      {
        recursionList(value, mapJsons[key]);
      }
    });
  }

  /*
   * 递归List集合直找到Map集合为止
   * @param value 数据库配置的值
   * @param mapJsons 内存中的值
   */
  void recursionList(List<dynamic> value, List<dynamic> mapJsons)
  {
    for (int i = 0; i < value.length; i ++)
    {
      dynamic item = value[i];
      if (item is Map)
      {
        childParaInit(item, mapJsons[i]);
      }
      else if (item is List)
      {
        recursionList(item, mapJsons[i]);
      }
    }
  }

  /*
   * 将数据库配置参数转换成(Map<String, Map<String, dynamic>>)通过插件名称可以取到初始化参数的Map
   * @param value 数据库配置的值
   * @param childPara  实际内存中的值
   */
  void convertChildNextInitPara(String value, dynamic childPara)
  {
    List<String> result = value.split(StringValueConstant.STR_COMMON_COMMA);
    List<Map<String, String>> keyName = json.decode(result.last);
    keyName.forEach((value)
    {
      value.forEach((pluginName, initparaKey)
      {
        Map<String, dynamic> map = mChildNextInitPara[pluginName];
        if (map == null)
        {
          mChildNextInitPara[pluginName] = {};
        }
        map[initparaKey] = childPara;
      });
    });
  }

  /*
   * 根据插件名称获取孩子初始化参数的值
   * @param pluginWidgetName 插件名称
   */
  Map<String, dynamic> getChildNextInitPara(String pluginWidgetName)
  {
    return mChildNextInitPara[pluginWidgetName];
  }

  /*
   * 是否为空Map
   */
  bool isEmptyMap()
  {
    return CxTextUtil.isEmptyMap(mChildNextInitPara);
  }
}

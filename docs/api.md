
# Introduce 说明


## intro规范
 ■用户登陆授权访问（基于http协议头验证）

 格式样例：--header "Authorization: Token token=3ZZbHWoiFvGkXpyioCaGN8vin+nqTrHxuaNMvHai8EkZluS3LHHK15yQykK3gFgO8ATFEm4KxFJmT0jEg5FLYA=="

 ■ 统一返回数据说明

 1: 所有时间格式为: DTS(数字时间戳)

 2: 空字符: ""

 3: 所有是否的布尔值返回: 0为false,1为true

 4: 空数组为: []


■ 所有返回状态为http协议状态

　如果请求失败，返回包含如下内容的JSON字符串：

 {
     "errcode":     <HttpCode  int>,
     "errmsg":   "<ErrMsg    string>"
 }

 ■ 统一分页参数（包含在meta标签中）

 *分页请求参数

  page: 页面号,per_page: 每页返回记录

 *分页返回

 包含在meta标签中

 {"meta":
   {"current_page":#当前页面,
    "next_page":null,
    "prev_page":null,
    "total_pages":#总页数,
    "total_count":#共计多少条}
 }


# Part1 用户管理

## 1、用户登录接口

### HTTP请求

`post /api/v1/sessions`

### Request 请求参数

参数名 | 是否必需 | 描述
-----| --------| -------
email  |  是   | Emial|
password| 是   | Password|

```shell
  curl -i -X POST -d "email=test@topdmc.com&password=123456"  --header "Authorization: Token token=3ZZbHWoiFvGkXpyioCaGN8vin+nqTrHxuaNMvHai8EkZluS3LHHK15yQykK3gFgO8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/sessions
```
### Response 响应

> 响应数据:

```json
{   
    access_token: token, expired_in_days: exp_days
}
```

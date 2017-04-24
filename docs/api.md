
# Introduce 说明


## intro规范
 ■用户登陆授权访问（基于http协议头验证）

 格式样例：--header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA=="

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



 # Part0 上传百度云

 ## 获取临时token接口

 ### HTTP请求

 `get /api/v1/sts_token`


 ```shell
   curl -i -X GET    --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/sts_token
 ```
 ### Response 响应

 > 响应数据:

 ```json
 {
  "accessKeyId": "df502159289811e7b48f6f90ae7dae38",
  "secretAccessKey": "be27232a12d6499dbc91b0812eb11f75",
  "sessionToken": "6IHTZwTmedrcJnQLrsaLRTyb66q5fmhopK1ltkaCg=",
  "createTime": "2017-04-24T02:51:10Z",
  "expiration": "2017-04-24T14:51:10Z",
  "userId": "f0693d510e03495e9b4eebb48ce2d68e"
}
 ```

# Part1 用户管理

## 1.1、用户登录接口

### HTTP请求

`post /api/v1/sessions`

### Request 请求参数

| 参数名      | 是否必需 | 描述       |
| -------- | ---- | -------- |
| email    | 是    | Emial    |
| password | 是    | Password |

```shell
  curl -i -X POST -d "email=test@topdmc.com&password=123456"  --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/sessions
```
### Response 响应

> 响应数据:

```json
{   
    access_token: token, expired_in_days: exp_days
}
```

## 1.2、用户列表接口

### HTTP请求

`get /api/v1/users`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| email  | 否    | Emial |
| name   | 否    | name  |
| status | 否    | 状态    |


```shell
  curl -i -X GET -d "email=test@topdmc.com&name=123456"  --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/users
```
### Response 响应

> 响应数据:

```json
users:[
  {   
    name,
    email,
    address,
    avatar_url,
    status
  },
....
]
```


## 1.3、新建用户接口

### HTTP请求

`POST /api/v1/users`

### Request 请求参数

| 参数名              | 是否必需 | 描述       |
| ---------------- | ---- | -------- |
| user[email]      | 是    | Emial    |
| user[name]       | 是    | name     |
| user[password]   | 是    | password |
| user[address]    | 是    | 地址       |
| user[status]     | 是    | 状态       |
| user[phone]      | 是    | 手机       |
| user[avatar_url] | 是    | 头像       |
| user[role_ids][] | 是    | 角色列表     |


```shell
  curl -i -X POST -d "user[email]=test@topdmc.com&user[name]=123456&user[password]=123456&user[address]=ssss&user[avatar_url]=sdfdfd&user[role_ids][]=1&user[role_ids]=2"  --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/users
```
### Response 响应

> 响应数据:

```json
  {   
  name,
  email,
  address,
  avatar_url,
  status
}
```


## 1.4、修改用户接口

### HTTP请求

`PUT /api/v1/users/:id`

### Request 请求参数

| 参数名              | 是否必需 | 描述    |
| ---------------- | ---- | ----- |
| user[email]      | 是    | Emial |
| user[name]       | 是    | name  |
| user[address]    | 是    | 地址    |
| user[status]     | 是    | 状态    |
| user[phone]      | 是    | 手机    |
| user[avatar_url] | 是    | 头像    |
| user[role_ids][] | 是    | 角色列表  |


```shell
  curl -i -X PUT -d "user[email]=wh@topdmc.com&user[name]=123456&user[address]=ssss&user[avatar_url]=sdfdfd&user[role_ids]=1&user[role_ids]=2"  --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/users/:id
```
### Response 响应

> 响应数据:

```json
 {   
  name,
  email,
  address,
  avatar_url,
  status
}
```


## 1.5、查看用户接口

### HTTP请求

`GET /api/v1/users/:id`


```shell
  curl -i -X GET    --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/users/:id
```
### Response 响应

> 响应数据:

```json
 user:
   {   
    name,
    email,
    address,
    avatar_url,
    status
  }
```


## 1.6、删除用户接口

### HTTP请求

`DELETE /api/v1/users/:id`


```shell
  curl -i -X DELETE    --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/users/:id
```
### Response 响应

> 响应数据:

```json
 user:
   {   
    name,
    email,
    address,
    avatar_url,
    status
  }
```
# Part2 角色管理

## 2.1、角色列表接口

### HTTP请求

`get /api/v1/roles`

### Request 请求参数

```shell
  curl -i -X GET  --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/roles
```
### Response 响应

> 响应数据:

```json
roles:[
  {   
    name,
    status
  },
....
]
```

## 2.2、新建角色接口

### HTTP请求

`post /api/v1/roles`

### Request 请求参数

| 参数名                    | 是否必需 | 描述   |
| ---------------------- | ---- | ---- |
| role[name]             | 是    | name |
| role[status]           | 是    | 状态   |
| role[permission_ids][] | 是    | 功能列表 |


```shell
  curl -i -X POST  -d "role[name]=sdfdf&role[status]=0&role[permission_ids][]=1"--header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/roles
```
### Response 响应

> 响应数据:

```json
  {   
    name,
    status
  }
```


## 2.3、修改角色接口

### HTTP请求

`PUT /api/v1/roles/:id`

### Request 请求参数

| 参数名                    | 是否必需 | 描述   |
| ---------------------- | ---- | ---- |
| role[name]             | 是    | name |
| role[status]           | 是    | 状态   |
| role[permission_ids][] | 是    | 功能列表 |

```shell
  curl -i -X PUT  -d "role[name]=sdfdf&role[status]=0&role[permission_ids][]=1&&role[permission_ids][]=2"--header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/roles/:id
```
### Response 响应

> 响应数据:

```json
  {   
    name,
    status
  }
```


## 2.4、查看角色接口

### HTTP请求

`GET /api/v1/roles/:id`

```shell
  curl -i -X GET  --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/roles/:id
```
### Response 响应

> 响应数据:

```json
  role: {   
    name,
    status,
    permissions: [{
      {"id":1,
      "name":"用户查看",
      "display_name":"查看"
      'status':1
      'rule_type': 1 权限类型(1:查询权限;2:编辑权限;3:审核)
    },
    ..
    ]
  }
```

## 2.5、删除角色接口

### HTTP请求

`DELETE /api/v1/roles/:id`

### Request 请求参数

```shell
  curl -i -X DELETE --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/roles/:id
```
## 2.6、角色功能列表接口

### HTTP请求

`GET /api/v1/roles/:role_id/permissions`

### Request 请求参数

```shell
  curl -i -X GET --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/roles/:role_id/permissions
```
### Response 响应

> 响应数据:

```json
{
  "groups":
   [{"id":1,
     "name":"系统管理",
     "subclass":[{
       "id":5,
       "name":"用户管理",
       "permissions": [{
               "id":1,
               "name":"用户查看",
               "display_name":"查看",
               "is_selectd" : true
              },
              {
                "id":2,
                "name":"用户编辑",
                "display_name":"编辑",
                "is_selectd" : true
               },
           ]},
         ....
      ]}
    ]
  }

```


# Part3 艺人管理

## 3.1. 创建艺人接口

### HTTP请求

`post /api/v1/artists`

### Request 请求参数

| 参数名                              | 是否必需 | 描述                       |
| -------------------------------- | ---- | ------------------------ |
| artist                           | 是    | 标志是艺人                    |
| name                             | 是    | 艺人名称                     |
| country_id                       | 否    | 国家ID                     |
| country_name                     | 否    | 国家名称                     |
| gender_type                      | 否    | 性别 [:male,:female,:team] |
| description                      | 否    | 备注                       |
| label_id                         | 否    | 唱片公司ID                   |
| label_name                       | 否    | 唱片公司名称                   |
| artist_resources_attributes_field       | 否    | 个人资源区分                   |
| resource_attributes_url         | 否    | 资源URL                    |
| resource_attributes_native_name | 否    | 文件原始名称                   |

#### 请求示例
`post /api/v1/artists`
```json
{
	"artist":{
		"name":"222222",
		"country_id":"1",
		"country_name":"吧2",
		"gender_type":"female",
		"description":"aaaaaaaaaaaaaa",
		"label_id":"1",
		"label_name":"dddaaa",
		"artist_resources_attributes":[{
			"field":1,
			"resource_attributes":{
			"url":"1aaaaadd44444ssssaa,,.ssa",
			"native_name":"1ddaalllllll"
		}
		}]
	}

}
```

### Response 响应

> 响应数据:

```json
{
  "artist": {
    "id": 1,
    "name": "222222",
    "gender_type": "female",
    "description": "aaaaaaaaaaaaaa",
    "operator": null,
    "approve_status": "todo",
    "not_through_reason": null,
    "deleted": false,
    "country": null,
    "resources": [
      {
        "id": 1,
        "field": 1,
        "resource": {
          "id": 1,
          "url": "1aaaaadd44444ssssaa,,.ssa",
          "deleted": false,
          "native_name": "1ddaalllllll",
          "created_at": "2017-04-19T16:39:25.000+08:00",
          "updated_at": "2017-04-19T16:39:25.000+08:00"
        }
      }
    ]
  }
}
```
## 3.2. 删除艺人接口

### HTTP请求

`delete /api/v1/artists/:id`

### Request 请求参数


| 参数名  | 是否必需 | 描述   |
| ---- | ---- | ---- |
| id   | 是    | 艺人ID |

#### 请求示例

`delete /api/v1/artists/8`

### Response 响应

> 响应数据:

```json
{
  "artist": {
    "id": 1,
    "name": "222222",
    "gender_type": "female",
    "description": "aaaaaaaaaaaaaa",
    "operator": null,
    "approve_status": "todo",
    "not_through_reason": null,
    "deleted": true,
    "country": null,
    "resources": []
  }
}
```
## 3.3. 更新艺人接口

### HTTP请求

`put /api/v1/artists/:id`

### Request 请求参数

| 参数名                              | 是否必需 | 描述                           |
| -------------------------------- | ---- | ---------------------------- |
| id                               | 是    | 艺人ID                         |
| artist                           | 是    | 标志是艺人                        |
| name                             | 否    | 艺人名称                         |
| country_id                       | 否    | 国家ID                         |
| country_name                     | 否    | 国家名称                         |
| gender_type                      | 否    | 性别 [:male,:female,:team]     |
| description                      | 否    | 备注                           |
| label_id                         | 否    | 唱片公司ID                       |
| label_name                       | 否    | 唱片公司名称                       |
| not_through_reason               | 否    | 审批未通过原因                       |
| approve_status                   | 否    | :agree,:disagree                       |
| artist_resources_attributes_id          | 否    | 艺人资源id                         |
| artist_resources_attributes_field       | 否    | 艺人个人资源区分                       |
| artist_resources_attributes__destroy    | 否    | 是否删除艺人资源文件[true,false] |
| resource_attributes_id          | 否    | 资源id                         |
| resource_attributes_url         | 否    | 资源URL                        |
| resource_attributes_native_name | 否    | 文件原始名称                       |

 注意⚠️ 更新artist_resources_attributes里面原有数据时候要加入艺人资源id ，如果不加艺人资源id 会创建新的数据,当不删除artist_resources_attributes里面数据时候_destroy 为false或不传此参数

#### 请求示例

`put /api/v1/artists/3`
```json
{
	"artist":{
		"name":"222222",
		"country_id":"1",
		"country_name":"吧333",
		"gender_type":"female",
		"description":"aaaaaaaaaaaaaa",
		"label_id":"1",
		"label_name":"dddaaa",
		"artist_resources_attributes":[{
			"id":1,
			"field":223444332,
      "_destroy":true,
			"resource_attributes":{
			"id":1,
			"url":"344443343aaaaadd44444ssssaa,,.ssa",
			"native_name":"144ddaalllllll"
			}
		}]
	}

}
```
### Response 响应

> 响应数据:

```json
{
  "artist": {
    "id": 1,
    "name": "222222",
    "gender_type": "female",
    "description": "aaaaaaaaaaaaaa",
    "operator": null,
    "approve_status": "todo",
    "not_through_reason": null,
    "deleted": false,
    "country": null,
    "resources": [
      {
        "id": 1,
        "field": 222,
        "resource": {
          "id": 1,
          "url": "3aaaaadd44444ssssaa,,.ssa",
          "native_name": "1ddaalllllll",
          "deleted": false,
          "created_at": "2017-04-19T16:39:25.000+08:00",
          "updated_at": "2017-04-19T16:55:18.000+08:00"
        }
      }
    ]
  }
}
```
## 3.4. 查询艺人列表接口

### HTTP请求

`get /api/v1/artists?size=2&page=2`

### Request 请求参数


| 参数名  | 是否必需 | 描述      |
| ---- | ---- | ------- |
| size | 是    | 每页显示的条数 |
| page | 否    | 第几页     |

#### 请求示例

`get /api/v1/artists?size=2&page=1`

### Response 响应

> 响应数据:

```json
{
  "artists": [
    {
      "id": 1,
      "name": "222222",
      "gender_type": "female",
      "description": "aaaaaaaaaaaaaa",
      "operator": null,
      "approve_status": "todo",
      "not_through_reason": null,
      "deleted": false,
      "country": null,
      "resources": [
        {
          "id": 1,
          "field": 222,
          "resource": {
            "id": 1,
            "url": "3aaaaadd44444ssssaa,,.ssa",
            "deleted": false,
            "native_name": "1ddaalllllll",
            "created_at": "2017-04-19T16:39:25.000+08:00",
            "updated_at": "2017-04-19T16:55:18.000+08:00"
          }
        }
      ]
    }
  ],
  "meta": {
    "page": 1,
    "total": 1
  }
}
```
## 3.5. 查询艺人详情接口

### HTTP请求

`get /api/v1/artists/:id`

### Request 请求参数


| 参数名  | 是否必需 | 描述   |
| ---- | ---- | ---- |
| id   | 是    | 艺人ID |

#### 请求示例

`get /api/v1/artists/8`
### Response 响应

> 响应数据:

```json
{
  "artist": {
    "id": 1,
    "name": "222222",
    "gender_type": "female",
    "description": "aaaaaaaaaaaaaa",
    "operator": null,
    "approve_status": "todo",
    "not_through_reason": null,
    "deleted": false,
    "country": null,
    "resources": [
      {
        "id": 1,
        "field": 222,
        "resource": {
          "id": 1,
          "url": "3aaaaadd44444ssssaa,,.ssa",
          "deleted": false,
          "native_name": "1ddaalllllll",
          "created_at": "2017-04-19T16:39:25.000+08:00",
          "updated_at": "2017-04-19T16:55:18.000+08:00"
        }
      }
    ]
  }
}

```
## 3.6. 批量审核通过艺人接口

### HTTP请求

`post /api/v1/artists/approve`

### Request 请求参数


| 参数名        | 是否必需 | 描述     |
| ---------- | ---- | ------ |
| artist_ids | 是    | 艺人ID数组 |

#### 请求示例

`put /api/v1/artists/approve`
```json
{
"artist_ids":[1]
}
```

### Response 响应

> 响应数据:

```json
{
  "artists": [
    {
      "id": 1,
      "name": "222222",
      "gender_type": "female",
      "description": "aaaaaaaaaaaaaa",
      "operator": null,
      "approve_status": "agree",
      "not_through_reason": null,
      "deleted": false,
      "country": null,
      "resources": [
        {
          "id": 1,
          "field": 222,
          "resource": {
            "id": 1,
            "url": "3aaaaadd44444ssssaa,,.ssa",
            "deleted": false,
            "native_name": "1ddaalllllll",
            "created_at": "2017-04-19T16:39:25.000+08:00",
            "updated_at": "2017-04-19T16:55:18.000+08:00"
          }
        }
      ]
    }
  ]
}
```





# Part6 版权方管理

## 6.1、版权方列表接口

### HTTP请求

`GET /api/v1/providers`

### Request 请求参数


```shell
  curl -i -X GET   --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/providers
```
### Response 响应

> 响应数据:

```json
{
  "providers": [
    {
      "id": 2,
      "name": "test",
      "property": "company",
      "contact": "sdfdfd",
      "tel": null,
      "address": "fdsfsdfsdf",
      "email": null,
      "bank_name": null,
      "account_no": null,
      "user_name": null,
      "cycle": null,
      "start_time": null,
      "status": "todo:待确定,agree:通过,disagree:未通过"
    }
  ],
  "meta": {
    "page": 1,
    "total": 1,
    "size": 10
  }
}
```

## 6.2、新建版权方

### HTTP请求

`POST  /api/v1/providers`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| name   | 是    | name  |
| property  | 是  | 属性 个人:personal公司:company|
| contact | 否    | 联系人   |
| tel | 否    | 电话   |
| address | 否    | 联系地址   |
| email | 否    | 邮箱   |
| bank_name | 否    | 开户行   |
| account_no | 否    | 结算账户   |
| user_name | 否    | 账户名   |
| cycle | 否    | 结算周期   |
| start_time | 否    | 结算开始时间   |
| status | 否    | todo:待确定,agree:通过,disagree:未通过   |

### Request 请求

```json
{
  "provider":
  {   
    "name": "eeeee",
    "property": "company",
    "email": "fdsfdsf",
    "address": "fdfdfd",
    "tel" : "323233232",
    "contact": "ddsdd",
    "status" : "agree",
    "cycle": "一周",
    "start_time": "2017-04-08",
    "bank_name": "开户行",
    "account_no": "结算账户",
    "user_name": "账户名"
  }
}

```

### Response 响应

> 响应数据:

```json
{
  "provider":
  {   
    "name": "eeeee",
    "property": "company",
    "email": "fdsfdsf",
    "address": "fdfdfd",
    "tel" : "323233232",
    "contact": "ddsdd",
    "status" : "agree"
  }
}
```


## 6.3、修改版权方

### HTTP请求

`PUT  /api/v1/providers/1`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| name   | 是    | name  |
| property  | 是  | 属性 个人:personal公司:company|
| contact | 否    | 联系人   |
| tel | 否    | 电话   |
| address | 否    | 联系地址   |
| email | 否    | 邮箱   |
| bank_name | 否    | 开户行   |
| account_no | 否    | 结算账户   |
| user_name | 否    | 账户名   |
| cycle | 否    | 结算周期   |
| start_time | 否    | 结算开始时间   |

### Request 请求

```json
{
  "provider":
  {   
    "name": "eeeee",
    "property": "company",
    "email": "fdsfdsf",
    "address": "fdfdfd",
    "tel" : "323233232",
    "contact": "ddsdd",
    "status" : "agree",
    "cycle": "一周",
    "start_time": "2017-04-08",
    "bank_name": "开户行",
    "account_no": "结算账户",
    "user_name": "账户名"
  }
}

```

### Response 响应

> 响应数据:

```json
{
  "provider":
  {   
    "name": "eeeee",
    "property": "company",
    "email": "fdsfdsf",
    "address": "fdfdfd",
    "tel" : '323233232'
    "contact": "ddsdd"
    "status" : "agree"
  }
}
```



## 6.4、版权方详情

### HTTP请求

`GET  /api/v1/providers/1`

### Response 响应

> 响应数据:

```json
{
  "provider":
  {   
    "name": "eeeee",
    "property": "company",
    "email": "fdsfdsf",
    "address": "fdfdfd",
    "tel" : "323233232",
    "contact": "ddsdd",
    "status" : "agree"
  }
}
```


## 6.5、删除版权方

### HTTP请求

`DELETE  /api/v1/providers/1`

### Response 响应

> 响应数据:
 NULL


## 6.6、批量通过版权方

### HTTP请求

`POST  /api/v1/providers/verify`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| provider_ids   | 是    | 版权方ids  |


### Request 请求

```json
{
 "provider_ids": [1,2]
}

```

### Response 响应

> 响应数据:
null

## 6.7、批量通过版权方

### HTTP请求

`POST  /api/v1/providers/verify`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| provider_ids   | 是    | 版权方ids  |
| reason  |  是    |  未通过原因 |

### Request 请求

```json
{
 "provider_ids": [1,2],
 "reason": "dddd"
}

```
### Response 响应

> 响应数据:
null


# Part7 合约管理

## 7.1、合约列表接口

### HTTP请求

`GET /api/v1/providers`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| contract_no   | 是    | 合约编号  |
| provider_name  |  是    |  版权方 |
| project_no  |  是    |  版权方 |
| contract_status  |  是    |  合约状态(valid:有效,near:快到期,due:过期,unvalid:未生效) |

```shell
  curl -i -X GET   --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/contracts
```
### Response 响应

> 响应数据:

```json
{
  "contracts": [
    {
      "id": 2,
      "contract_no": "test",
      "project_no": "company",
      "provider_name": "sdfdfd",
      "authorize_valid_cnt": "有效授权数量",
      "authorize_due_cnt": "过期授权数量",
      "status" : "状态",
      "contract_status" : "合约状态",
      "updated_at": "2017-04",
      "start_time": null,
      "end_time": null
    }
  ],
  "meta": {
    "page": 1,
    "total": 1,
    "size": 10
  }
}
```

## 7.2、新建合约

### HTTP请求

`POST  /api/v1/contracts`

### Request 请求参数


```json
    {"contract":
	     {
	      "provider_id":2,
	     "department_id":1,
         "project_no":"32323",
         "contract_no":"32323",
         "start_time":"2016-11-17","end_time":"2017-12-17",
         "allow_overdue":false,"pay_type":"default",
         "pay_amount":10,"desc":"dfdfdfsss",
         "contract_resources_attributes":[{"field":1,"resource_attributes":{"url":"33333","native_name":"eeeeee"}}],
         "authorizes_attributes":[{"currency_id":1,"account_id":1,
         "start_time":"2016-11-17","end_time":"2016-12-17",
          "contract_resources_attributes":[{"field":1,"resource_attributes":{"url":"33333","native_name":"eeeeee"}}],
          "authorized_businesses_attributes":[{"authorized_range_id":1,"divided_point":50,
          "authorized_area_ids":[124]}]
          }]
      }
}

```

### Response 响应

> 响应数据:
 null

## 7.3、修改合约

### HTTP请求

`PUT  /api/v1/contracts/1`

### Request 请求参数


```json
{"contract":
   {
    "id":2
    "provider_id":2,
   "department_id":1,
     "project_no":"32323",
     "contract_no":"32323",
     "start_time":"2016-11-17","end_time":"2017-12-17",
     "allow_overdue":false,"pay_type":"default",
     "pay_amount":10,"desc":"dfdfdfsss",
     "contract_resources_attributes":[{"id":2,"field":1,"resource_attributes":{"url":"33333","native_name":"eeeeee"}}],
     "authorizes_attributes":[{"id":2,"currency_id":1,"account_id":1,
     "start_time":"2016-11-17","end_time":"2016-12-17",
      "contract_resources_attributes":[{"id":2,"field":1,"resource_attributes":{"url":"33333","native_name":"eeeeee"}}],
      "authorized_businesses_attributes":[{"id":2,"authorized_range_id":1,"divided_point":50,
      "authorized_area_ids":[124]}]
      }]
  }
}
```

### Response 响应

> 响应数据:
 null



## 7.4、合约详情

### HTTP请求

`GET  /api/v1/contracts/1`

### Response 响应

> 响应数据:

```json
{
  "contract": {
          "id":28,"provider_id":1,"provider_name":"版权方",
          "project_no":"ssss","contract_no":"sssss",
          "signing_company":"32aa","start_time":"2016-11-17",
          "end_time":"2016-12-17","allow_overdue":false,
          "pay_type":"default","pay_amount":10,"desc":"dfdfdfsss","reason":"dddd",
          "contract_files":[{"id":177,"url":"333","filename":"nasss"}],
          "authorizes":[{"id":29,"currency_id":1,"account_id":1,
              "start_time":"2016-11-17","end_time":"2016-12-17",
              "contract_files":[{"id":176,"url":"ddd","filename":"nasss"}],
              "authorized_businesses":[{"id":93,"business_id":1,
              "business_type":"AuthorizedRange","is_whole":0,"divided_point":50,
              "authorized_area_ids":[124]}]
          }]
        }
}
```


## 7.5、删除合约

### HTTP请求

`DELETE  /api/v1/contracts/1`

### Response 响应

> 响应数据:
 NULL


## 7.6、批量通过合约

### HTTP请求

`POST  /api/v1/contracts/verify`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| contract_ids   | 是    | 版权方ids  |


### Request 请求

```json
{
 "contract_ids": [1,2]
}

```

### Response 响应

> 响应数据:
null

## 7.7、批量不通过合约

### HTTP请求

`POST  /api/v1/contracts/unverify`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| contract_ids   | 是    | 版权方ids  |
| reason  |  是    |  未通过原因 |

### Request 请求

```json
{
 "contract_ids": [1,2],
 "reason": "dddd"
}

```
### Response 响应

> 响应数据:
null

# Part8 结算管理

## 8.1. 创建货币接口

### HTTP请求

`post /api/v1/exchange_rates`

### Request 请求参数

| 参数名                              | 是否必需 | 描述                       |
| -------------------------------- | ---- | ------------------------ |
| exchange_rate                           | 是    | 标志是货币                    |
| currency                             | 是    | 货币                     |
| settlement_currency                       | 是    | 结算货币                    |
| exchange_ratio                     | 是   |      汇率                |
| status                      | 是   | 状态 [:enabled, :disabled] |
| operator                      | 是   | 操作人                       |

#### 请求示例
`post /api/v1/exchange_rates`
```json
{
	"exchange_rate":{
		"currency":"韩币",
		"settlement_currency":"人民币",
		"exchange_ratio":"1:12",
		"status":"enabled",
		"operator":"aasd"
	}

}
```

### Response 响应

> 响应数据:

```json
{
  "id": 2,
  "currency": "韩币",
  "settlement_currency": "人民币",
  "exchange_ratio": "1:12",
  "status": "enabled",
  "deleted": false,
  "operator": "aasd",
  "created_at": "2017-04-20T12:13:45.000+08:00",
  "updated_at": "2017-04-20T12:13:45.000+08:00"
}
```
## 8.2. 删除货币接口

### HTTP请求

`Delete /api/v1/exchange_rates/:id`

### Request 请求参数

| 参数名                              | 是否必需 | 描述                       |
| -------------------------------- | ---- | ------------------------ |
| id                           | 是    | 货币id                    |

#### 请求示例
`Delete /api/v1/exchange_rates/2`

### Response 响应

> 响应数据:

```json
{
  "id": 2,
  "currency": "韩币",
  "settlement_currency": "人民币",
  "exchange_ratio": "1:12",
  "status": "enabled",
  "deleted": true,
  "operator": "aasd",
  "created_at": "2017-04-20T12:13:45.000+08:00",
  "updated_at": "2017-04-20T12:13:45.000+08:00"
}
```

## 8.3. 更新货币接口

### HTTP请求

`Put /api/v1/exchange_rates/:id`

### Request 请求参数

| 参数名                              | 是否必需 | 描述                       |
| -------------------------------- | ---- | ------------------------ |
| exchange_rate                           | 是    | 标志是货币                    |
| currency                             | 否    | 货币                     |
| settlement_currency                       | 否    | 结算货币                    |
| exchange_ratio                     | 否   |      汇率                |
| status                      | 否   | 状态 [:enabled, :disabled] |
| operator                      | 否   | 操作人                       |

#### 请求示例
`post /api/v1/exchange_rates/2`
```json
{
	"exchange_rate":{
		"currency":"韩币1",
		"settlement_currency":"人民dddd币1",
		"exchange_ratio":"1:12",
		"status":"disabled",
		"operator":"aasd"
	}

}
```

### Response 响应

> 响应数据:

```json
{
  "id": 2,
  "currency": "韩币1",
  "settlement_currency": "人民dddd币1",
  "exchange_ratio": "1:12",
  "status": "disabled",
  "operator": "aasd",
  "deleted": false,
  "created_at": "2017-04-20T12:13:45.000+08:00",
  "updated_at": "2017-04-20T12:28:15.000+08:00"
}
```
## 8.4. 查看货币列表接口

### HTTP请求

`get /api/v1/exchange_rates`

### Request 请求参数


#### 请求示例
`get /api/v1/exchange_rates`

### Response 响应

> 响应数据:

```json
[
  {
    "id": 2,
    "currency": "韩币11111111",
    "settlement_currency": "人民dddd币1",
    "exchange_ratio": "1:12",
    "status": "disabled",
    "deleted": false,
    "operator": "aasd",
    "created_at": "2017-04-20T12:13:45.000+08:00",
    "updated_at": "2017-04-20T14:25:41.000+08:00"
  }
]
```
## 8.5. 查看货币详情接口

### HTTP请求

`get /api/v1/exchange_rates/:id`

### Request 请求参数
| 参数名                              | 是否必需 | 描述                       |
| -------------------------------- | ---- | ------------------------ |
| id                           | 是    | 货币ID                    |

#### 请求示例
`get /api/v1/exchange_rates/2`

### Response 响应

> 响应数据:

```json
{
  "id": 2,
  "currency": "韩币11111111",
  "settlement_currency": "人民dddd币1",
  "exchange_ratio": "1:12",
  "status": "disabled",
  "deleted": false,
  "operator": "aasd",
  "created_at": "2017-04-20T12:13:45.000+08:00",
  "updated_at": "2017-04-20T14:25:41.000+08:00"
}
```

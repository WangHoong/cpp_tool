
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


# Part1 用户管理

## 1.1、用户登录接口

### HTTP请求

`post /api/v1/sessions`

### Request 请求参数

参数名 | 是否必需 | 描述
-----| --------| -------
email  |  是   | Emial|
password| 是   | Password|

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

参数名 | 是否必需 | 描述
-----| --------| -------
email  |  否  | Emial|
name| 否   | name|
status | 否   | 状态|


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

参数名 | 是否必需 | 描述
-----| --------| -------
user[email]  |   是  | Emial|
user[name] | 是   | name|
user[password] | 是   | password|
user[address] | 是   |地址|
user[status] | 是   |状态|
user[phone] | 是   |手机|
user[avatar_url] | 是   |头像|
user[role_ids][] |是 | 角色列表|


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

参数名 | 是否必需 | 描述
-----| --------| -------
user[email]  |   是  | Emial|
user[name] | 是   | name|
user[address] | 是   | 地址|
user[status] | 是   | 状态|
user[phone] | 是   |手机|
user[avatar_url] | 是   |头像|
user[role_ids][] |是 | 角色列表|


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

参数名 | 是否必需 | 描述
-----| --------| -------
role[name] | 是   | name|
role[status] | 是   | 状态|
role[permission_ids][] |是 | 功能列表|


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

参数名 | 是否必需 | 描述
-----| --------| -------
role[name] | 是   | name|
role[status] | 是   | 状态|
role[permission_ids][] |是 | 功能列表|

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
## 2.6、功能列表接口

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

| 参数名      | 是否必需 | 描述       |
| -------- | ---- | -------- |
| artist     | 是    | 标志是艺人    |
| name     | 是    | 艺人名称    |
| country_id | 否    | 国家ID |
| country_name | 否    | 国家名称 |
| gender_type | 否    | 性别 [:male,:female,:team]|
| description | 否    | 备注 |
| label_id | 否    | 唱片公司ID |
| label_name | 否    | 唱片公司名称 |
| resources_attributes_url | 否    | 资源URL |
| resources_attributes_native_name | 否    | 文件原始名称 |
| resources_attributes_field | 否    | 个人资源区分 |

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
		"resources_attributes":[{
			"url":"aaaaadd44444ssssaa,,.ssa",
			"native_name":"ddaalllllll",
			"field":"s"
		}]
	}

}
```

### Response 响应

> 响应数据:

```json
{
  "artist": {
    "id": 8,
    "name": "222222",
    "gender_type": "female",
    "description": "aaaaaaaaaaaaaa",
    "operator": null,
    "approve_status": "todo",
    "not_through_reason": null,
    "country": {
      "id": 1,
      "continent_id": 2,
      "name": "xx",
      "lower_name": "xx",
      "country_code": "11",
      "full_name": "x",
      "cname": "xxxxx",
      "full_cname": "xxxxxxxx",
      "remark": "xxxxxxx"
    },
    "resources": [
      {
        "id": 24,
        "target_id": 8,
        "target_type": "Artist",
        "url": "aaaaadd44444ssssaa,,.ssa",
        "status": null,
        "native_name": "ddaalllllll",
        "field": 0,
        "created_at": "2017-04-06T17:48:40.000+08:00",
        "updated_at": "2017-04-06T17:48:40.000+08:00"
      }
    ]
  }
}
```
## 3.2. 删除艺人接口

### HTTP请求

`delete /api/v1/artists/:id`

### Request 请求参数


| 参数名      | 是否必需 | 描述       |
| -------- | ---- | -------- |
| id     | 是    | 艺人ID    |

#### 请求示例

`delete /api/v1/artists/8`

### Response 响应

> 响应数据:

```json
true
```
## 3.3. 更新艺人接口

### HTTP请求

`put /api/v1/artists/:id`

### Request 请求参数

| 参数名      | 是否必需 | 描述       |
| -------- | ---- | -------- |
| id     | 是    | 艺人ID    |
| artist     | 是   | 标志是艺人    |
| name     | 否    | 艺人名称    |
| country_id | 否    | 国家ID |
| country_name | 否    | 国家名称 |
| gender_type | 否    | 性别 [:male,:female,:team]|
| description | 否    | 备注 |
| label_id | 否    | 唱片公司ID |
| label_name | 否    | 唱片公司名称 |
| resources_attributes_id | 否    | 资源id |
| resources_attributes_url | 否    | 资源URL |
| resources_attributes_native_name | 否    | 文件原始名称 |
| resources_attributes_field | 否    | 个人资源区分 |
| resources_attributes_status | 否    | 是否删除资源文件[:disabled,:enabled] |

#### 请求示例
`put /api/v1/artists/8`
```json
{
	"artist":{
		"name":"277777779922",
		"country_id":"1",
		"country_name":"吧2222222",
		"gender_type":"female",
		"description":"aaaa777799aaaaaaaaaa",
		"label_id":"1",
		"label_name":"d777ddaaa99",
		"resources_attributes":[{
			"id":15,
			"url":"aaaaadd777799sjjajajajajahahasssaa,,.ssa",
			"native_name":"ddaalll77llll",
      "field":"ss",
      "status":"disabled"
		}]
	}

}

### Response 响应

> 响应数据:

```json
true
```
## 3.4. 查询艺人列表接口

### HTTP请求

`get /api/v1/artists?size=2&page=2`

### Request 请求参数


| 参数名      | 是否必需 | 描述       |
| -------- | ---- | -------- |
| size     | 是    | 每页显示的条数    |
| page     | 否    | 第几页    |

#### 请求示例

`get /api/v1/artists?size=2&page=2`

### Response 响应

> 响应数据:

```json
{
  "artists": [
    {
      "id": 5,
      "name": "222222",
      "gender_type": "female",
      "description": "aaaaaaaaaaaaaa",
      "operator": null,
      "approve_status": "todo",
      "not_through_reason": null,
      "country": {
        "id": 1,
        "continent_id": 2,
        "name": "xx",
        "lower_name": "xx",
        "country_code": "11",
        "full_name": "x",
        "cname": "xxxxx",
        "full_cname": "xxxxxxxx",
        "remark": "xxxxxxx"
      },
      "resources": [
        {
          "id": 9,
          "target_id": 5,
          "target_type": "Artist",
          "url": "aaaaadd44444ssssaa,,.ssa",
          "status": null,
          "native_name": "ddaalllllll",
          "field": null,
          "created_at": "2017-04-06T12:05:45.000+08:00",
          "updated_at": "2017-04-06T12:05:45.000+08:00"
        },
        {
          "id": 10,
          "target_id": 5,
          "target_type": "Artist",
          "url": "aaaaadd555552ssssaa,,.ssa",
          "status": null,
          "native_name": null,
          "field": 1,
          "created_at": "2017-04-06T12:05:45.000+08:00",
          "updated_at": "2017-04-06T12:05:45.000+08:00"
        },
        {
          "id": 11,
          "target_id": 5,
          "target_type": "Artist",
          "url": "aaaaad666663sssssaa,,.ssa",
          "status": null,
          "native_name": null,
          "field": null,
          "created_at": "2017-04-06T12:05:45.000+08:00",
          "updated_at": "2017-04-06T12:05:45.000+08:00"
        }
      ]
    },
    {
      "id": 4,
      "name": "222222",
      "gender_type": "female",
      "description": "aaaaaaaaaaaaaa",
      "operator": null,
      "approve_status": "todo",
      "not_through_reason": null,
      "country": {
        "id": 1,
        "continent_id": 2,
        "name": "xx",
        "lower_name": "xx",
        "country_code": "11",
        "full_name": "x",
        "cname": "xxxxx",
        "full_cname": "xxxxxxxx",
        "remark": "xxxxxxx"
      },
      "resources": [
        {
          "id": 6,
          "target_id": 4,
          "target_type": "Artist",
          "url": "aaaaadd44444ssssaa,,.ssa",
          "status": null,
          "native_name": "ddaalllllll",
          "field": null,
          "created_at": "2017-04-06T12:03:41.000+08:00",
          "updated_at": "2017-04-06T12:03:41.000+08:00"
        },
        {
          "id": 7,
          "target_id": 4,
          "target_type": "Artist",
          "url": "aaaaadd555552ssssaa,,.ssa",
          "status": null,
          "native_name": null,
          "field": 1,
          "created_at": "2017-04-06T12:03:41.000+08:00",
          "updated_at": "2017-04-06T12:03:41.000+08:00"
        },
        {
          "id": 8,
          "target_id": 4,
          "target_type": "Artist",
          "url": "aaaaad666663sssssaa,,.ssa",
          "status": null,
          "native_name": null,
          "field": null,
          "created_at": "2017-04-06T12:03:41.000+08:00",
          "updated_at": "2017-04-06T12:03:41.000+08:00"
        }
      ]
    }
  ],
  "meta": {
    "page": 2,
    "total": 7
  }
}
```
## 3.5. 查询艺人详情接口

### HTTP请求

`get /api/v1/artists/:id`

### Request 请求参数


| 参数名      | 是否必需 | 描述       |
| -------- | ---- | -------- |
| id     | 是    | 艺人ID    |

#### 请求示例

`get /api/v1/artists/8`
### Response 响应

> 响应数据:

```json
{
  "artist": {
    "id": 8,
    "name": "222222",
    "gender_type": "female",
    "description": "aaaaaaaaaaaaaa",
    "operator": null,
    "approve_status": "todo",
    "not_through_reason": null,
    "country": {
      "id": 1,
      "continent_id": 2,
      "name": "xx",
      "lower_name": "xx",
      "country_code": "11",
      "full_name": "x",
      "cname": "xxxxx",
      "full_cname": "xxxxxxxx",
      "remark": "xxxxxxx"
    },
    "resources": [
      {
        "id": 24,
        "target_id": 8,
        "target_type": "Artist",
        "url": "aaaaadd44444ssssaa,,.ssa",
        "status": null,
        "native_name": "ddaalllllll",
        "field": 0,
        "created_at": "2017-04-06T17:48:40.000+08:00",
        "updated_at": "2017-04-06T17:48:40.000+08:00"
      }
    ]
  }
}

```
## 3.6. 批量审核通过艺人接口

### HTTP请求

`put /api/v1/artists/approve`

### Request 请求参数


| 参数名      | 是否必需 | 描述       |
| -------- | ---- | -------- |
| artist_ids     | 是    | 艺人ID数组    |

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
      "country": null,
      "resources": [
        {
          "id": 1,
          "target_id": 1,
          "target_type": "Artist",
          "url": "aaaaadd44444ssssaa,,.ssa",
          "status": "enabled",
          "native_name": "ddaalllllll",
          "field": 0,
          "created_at": "2017-04-06T18:20:33.000+08:00",
          "updated_at": "2017-04-06T18:20:33.000+08:00"
        }
      ]
    }
  ]
}
```

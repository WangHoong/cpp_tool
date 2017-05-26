

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
    "tel" : "323233232",
    "contact": "ddsdd",
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
##如果单个审核 provider_ids:[1]

### Request 请求

```json
{
 "provider_ids": [1,2]  
}

```

### Response 响应

> 响应数据:
null

## 6.7、审核不通过版

### HTTP请求

`POST  /api/v1/providers/unverify`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| id   | 是    | 版权方id |
| reason  |  是    |  未通过原因 |

### Request 请求

```json
{
 "id": 1,
 "reason": "dddd"
}

```
### Response 响应

> 响应数据:
null

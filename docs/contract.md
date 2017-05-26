
# Part7 合约管理

## 7.1、合约列表接口

### HTTP请求

`GET /api/v1/cp/contracts`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| contract_no   | 是    | 合约编号  |
| contract_name  |  是    |  版权方 |
| project_no  |  是    |  版权方 |
| contract_status  |  是    |  合约状态(valid:有效,near:快到期,due:过期,unvalid:未生效) |

```shell
  curl -i -X GET   --header "Authorization: Token token=O8ATFEm4KxFJmT0jEg5FLYA==" http://localhost:3000/api/v1/cp/contracts
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
      "contract_name": "sdfdfd",
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

`POST  /api/v1/cp/contracts`

### Request 请求参数


```json
    {"contract":
	     {
	      "contract_id":2,
	     "department_id":1,
         "project_no":"32323",
         "contract_no":"32323",
         "start_time":"2016-11-17","end_time":"2017-12-17",
         "allow_overdue":false,"pay_type":"default",
         "pay_amount":10,"desc":"dfdfdfsss",
         "contract_resources_attributes": [{"url":"33333","file_name":"eeeeee"}],
         "authorizes_attributes":[{"currency_id":1,"account_id":1,
         "start_time":"2016-11-17","end_time":"2016-12-17",
          "contract_resources_attributes":[{"url":"33333","file_name":"eeeeee"}],
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

`PUT  /api/v1/cp/contracts/1`

### Request 请求参数


```json
{"contract":
   {
    "id":2
    "contract_id":2,
   "department_id":1,
     "project_no":"32323",
     "contract_no":"32323",
     "start_time":"2016-11-17","end_time":"2017-12-17",
     "allow_overdue":false,"pay_type":"default",
     "pay_amount":10,"desc":"dfdfdfsss",
     "contract_resources_attributes":[{"id":1,"url":"33333","file_name":"eeeeee"}],
     "authorizes_attributes":[{"id":2,"currency_id":1,"account_id":1,
     "start_time":"2016-11-17","end_time":"2016-12-17",
      "contract_resources_attributes":[{"id":1,"url":"33333","file_name":"eeeeee"}],
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

`GET  /api/v1/cp/contracts/1`

### Response 响应

> 响应数据:

```json
{
  "contract": {
          "id":18,"contract_id":1,"contract_name":"版权方",
          "project_no":"ssss","contract_no":"sssss",
          "signing_company":"32aa","start_time":"2016-11-17",
          "end_time":"2016-12-17","allow_overdue":false,
          "pay_type":"default","pay_amount":10,"desc":"dfdfdfsss","reason":"dddd",
          "contract_resources": [
              {
                "id": 2,
                "target_id": 18,
                "target_type": "Cp::Contract",
                "file_name": "dfdf",
                "url": "33333"
              }
            ],
          "authorizes":[{"id":29,"currency_id":1,"account_id":1,
              "start_time":"2016-11-17","end_time":"2016-12-17",
              "contract_resources": [
                  {
                    "id": 1,
                    "target_id": 18,
                    "target_type": "Cp::Authorize",
                    "file_name": "dfdfd",
                    "url": "33333"
                  }
                ],
              "authorized_businesses":[{"id":93,"business_id":1,
              "business_type":"AuthorizedRange","is_whole":0,"divided_point":50,
              "authorized_area_ids":[124]}]
          }]
        }
}
```


## 7.5、删除合约

### HTTP请求

`DELETE  /api/v1/cp/contracts/1`

### Response 响应

> 响应数据:
 NULL


## 7.6、通过合约

### HTTP请求

`POST  /api/v1/cp/contracts/:id/verify`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| id   | 是    | id |


### Request 请求

```json
{
 "id": 1
}

```

### Response 响应

> 响应数据:
null



## 6.8、批量审核通过

### HTTP请求

`POST  /api/v1/contracts/approve`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| contract_ids   | 是    | ids |


### Request 请求

```json
{
 "contract_ids": [1,2]
}

```
### Response 响应

> 响应数据:
null


## 7.7、合约不通过

### HTTP请求

`POST  /api/v1/cp/contracts/:id/unverify`

### Request 请求参数

| 参数名    | 是否必需 | 描述    |
| ------ | ---- | ----- |
| id   | 是    | 版权方id  |
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

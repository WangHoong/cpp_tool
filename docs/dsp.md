# Part3 渠道方管理

## 3.1. 创建渠道方接口

### HTTP请求

`post /api/v1/dsps`

### Request 请求参数

| 参数名                              | 是否必需 | 描述                       |
| -------------------------------- | ---- | ------------------------ |
| name                             | 是    | 渠道方名称                     |
| department_id                    | 否    | 部门                     |
| is_agent                         | 否    | 是否代理                    |
| contact                      | 否    |  联系人                   |
| address                            | 否    |    地址                     |
| tel                           | 否    |           电话         |
| email                            | 否    | email                   |
| desc                              | 否    | 描述                   |

#### 请求示例
`post /api/v1/dsps`
```json
{
	"dsp": {
		"name": "genre",
		"department_id": 1,
		"is_agent": true,
		"contact": "folk",
		"address": "sdsdfsdf",
		"tel": "1223232332",
		"email": "v1000",
		"desc": "sfdsdfnsfksnvksnvkjnvkjnv"
	}
}

}
```

### Response 响应

> 响应数据:

```json
{
  "dsp": {
		"name": "genre",
 		"department_id": 1,
 		"is_agent": true,
 		"contact": "folk",
 		"address": "sdsdfsdf",
 		"tel": "1223232332",
 		"email": "v1000",
 		"desc": "sfdsdfnsfksnvksnvkjnvkjnv"
  }
}
```
## 3.2. 删除渠道方接口

### HTTP请求

`delete /api/v1/dsps/:id`

### Request 请求参数


| 参数名  | 是否必需 | 描述   |
| ---- | ---- | ---- |
| id   | 是    | 渠道方ID |

#### 请求示例

`delete /api/v1/artists/9`

### Response 响应

> 响应数据:

```json
{
  "dsp": {
		"name": "genre",
 		"department_id": 1,
		"department_name":"dddfd",
 		"is_agent": true,
 		"contact": "folk",
 		"address": "sdsdfsdf",
 		"tel": "1223232332",
 		"email": "v1000",
 		"desc": "sfdsdfnsfksnvksnvkjnvkjnv"
  }
}
```
## 3.3. 更新渠道方接口

### HTTP请求

`put /api/v1/dsps/:id`

### Request 请求参数

| 参数名                              | 是否必需 | 描述                       |
| -------------------------------- | ---- | ------------------------ |
| name                             | 是    | 渠道方名称                     |
| department_id                    | 否    | 部门                     |
| is_agent                         | 否    | 是否代理                    |
| contact                      | 否    |  联系人                   |
| address                            | 否    |    地址                     |
| tel                           | 否    |           电话         |
| email                            | 否    | email                   |
| desc                              | 否    | 描述                   |

#### 请求示例

`put /api/v1/dsps/10`
```json
{
	"dsp": {
		"name": "genre",
			"department_id": 1,
			"is_agent": true,
			"contact": "folk",
			"address": "sdsdfsdf",
			"tel": "1223232332",
			"email": "v1000",
			"desc": "sfdsdfnsfksnvksnvkjnvkjnv"
	}
}
```
### Response 响应

> 响应数据:

```json
{
  "dsp": {
		"name": "genre",
			"department_id": 1,
			"is_agent": true,
			"contact": "folk",
			"address": "sdsdfsdf",
			"tel": "1223232332",
			"email": "v1000",
			"desc": "sfdsdfnsfksnvksnvkjnvkjnv"
  }
}
```
## 3.4. 查询渠道方列表接口

### HTTP请求

`get /api/v1/dsps?size=2&page=1`

### Request 请求参数


| 参数名  | 是否必需 | 描述      |
| ---- | ---- | ------- |
| size | 是    | 每页显示的条数 |
| page | 否    | 第几页     |

#### 请求示例

`get /api/v1/dsps?size=2&page=1`

### Response 响应

> 响应数据:

```json
{
  "dsps": [
    {
			"id": 10,
			"name": "genre",
	  		"department_id": 1,
	 	  	"department_name":"dddfd",
	  		"is_agent": true,
	  		"contact": "folk",
	  		"address": "sdsdfsdf",
	  		"tel": "1223232332",
	  		"email": "v1000",
	  		"desc": "sfdsdfnsfksnvksnvkjnvkjnv"
    },
    {
      "id": 10,
			"name": "genre",
 			 "department_id": 1,
 		  "department_name":"dddfd",
 			 "is_agent": true,
 			 "contact": "folk",
 			 "address": "sdsdfsdf",
 			 "tel": "1223232332",
 			 "email": "v1000",
 			 "desc": "sfdsdfnsfksnvksnvkjnvkjnv"
    }
  ],
  "meta": {
    "page": 1,
    "total": 6
  }
}
```
## 3.5. 查询渠道方详情接口

### HTTP请求

`get /api/v1/dsps/:id`

### Request 请求参数


| 参数名  | 是否必需 | 描述   |
| ---- | ---- | ---- |
| id   | 是    | 渠道方ID |

#### 请求示例

`get /api/v1/dsps/10`
### Response 响应

> 响应数据:

```json
{
  "dsp": {
		"name": "genre",
			"department_id": 1,
	   	"department_name":"dddfd",
			"is_agent": true,
			"contact": "folk",
			"address": "sdsdfsdf",
			"tel": "1223232332",
			"email": "v1000",
			"desc": "sfdsdfnsfksnvksnvkjnvkjnv"
  }
}

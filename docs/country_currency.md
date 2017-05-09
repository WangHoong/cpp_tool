# Part1 国家管理

## 1.1. 查询国家列表接口

### HTTP请求

`get /api/v1/countries?size=2&page=1`

### Request 请求参数


| 参数名  | 是否必需 | 描述      |
| ---- | ---- | ------- |
| size | 是    | 每页显示的条数 |
| page | 否    | 第几页     |

#### 请求示例

`get /api/v1/countries?size=2&page=1`

### Response 响应

> 响应数据:

```json
{
  "countries": [
    {
      "id": 1,
      "continent": {
        "id": 3,
        "cn_name": "非洲",
        "en_name": "Africa"
      },
      "name": "Cameroon",
      "lower_name": "the republic of cameroon",
      "country_code": "CMR",
      "full_name": "the Republic of Cameroon",
      "cname": "喀麦隆",
      "full_cname": "喀麦隆共和国",
      "remark": "喀麦隆共和国（法语：République du Cameroun）通称喀麦隆，是位于非洲中西部的单一制共和国，西方与尼日利亚接壤，东北与东边分别和乍得与中非相靠，南方则与赤道几内亚、加蓬及刚果共和国毗邻。"
    }....
  ],
  "meta": {
    "page": 1,
    "total": 211
  }
}
```



# Part2 货币管理
## 2.1. 查看货币列表接口

### HTTP请求

`get /api/v1/currencies`

### Response 响应

> 响应数据:

```json
[
  {
    "id": 1,
    "name": "人民币"
  },
  {
    "id": 2,
    "name": "英镑"
  },
  {
    "id": 3,
    "name": "美元"
  },
  {
    "id": 4,
    "name": "港币"
  }
]
```

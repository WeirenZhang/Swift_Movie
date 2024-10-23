# MoyaResultValidate

[![CI Status](https://img.shields.io/travis/insect/MoyaResultValidate.svg?style=flat)](https://travis-ci.org/insect/MoyaResultValidate)
[![Version](https://img.shields.io/cocoapods/v/MoyaResultValidate.svg?style=flat)](https://cocoapods.org/pods/MoyaResultValidate)
[![License](https://img.shields.io/cocoapods/l/MoyaResultValidate.svg?style=flat)](https://cocoapods.org/pods/MoyaResultValidate)
[![Platform](https://img.shields.io/cocoapods/p/MoyaResultValidate.svg?style=flat)](https://cocoapods.org/pods/MoyaResultValidate)

## Why?

Sometimes we need to verify that the data returned by the server is reasonable, when Moya returns `Result.success`.

JSON returned by the server.

```json
{
  "code": 2000,
  "msg": "success",
  "data": ...
}
```

Validate the JSON  or XML or other type results. It seems not elegant.

```swift
provider.request(.baidu) { result in
    switch result {
    case let .success(response):
	if response["code"] == 2000 {
          /// success code
        } else {
          /// error code
        }
    case let .failure(error):
        break
    }
}
```

## Use MoyaResultValidate

1. Import.

```swift
import MoyaResultValidate
```

2. Add plugin to Moya.

```swift
MoyaResultValidatePlugin()
```

3. Let you already comply with the  `TargetType`  enum also implemented `MoyaResultValidateable` protocol.

```swift
extension RequestApi: MoyaResultValidateable {
    
    func isResultSuccess(response: Response) -> Bool {
        // Validation rules
    }
}
```

The it will work.Your request will look like this.

The ` Result.success(response)`  that does not match isResultSuccess will be transferred to `Result.Failure`.

You can use `error.asValidateError` to get `Moya.Response`.

```swift
provider.request(.baidu) { result in
    switch result {
    case let .success(response):
				// succees 
    case let .failure(error):
      	// You can use error.asValidateError get Moya.Response.
        error.asValidateError?.response
    }
}
```

## Requirements

- iOS 10.0 or later

## Installation

MoyaResultValidate is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MoyaResultValidate'
```

## License

MoyaResultValidate is available under the MIT license. See the LICENSE file for more info.

# SkinCalc - 多皮肤计算器

一款支持多种主题皮肤切换的全功能计算器 Android 应用。

## 功能特性

- **基础计算器** - 四则运算，实时结果显示
- **科学计算器** - sin/cos/tan/log/ln/√/x²/xʸ/x!/π/e，支持 DEG/RAD 切换
- **汇率换算器** - 接入 ExchangeRate-API，支持30+种货币实时换算
- **单位换算器** - 长度、重量、温度、面积、体积、速度六大类单位换算
- **5款精美皮肤** - 多巴胺、赛博朋克、莫兰迪、森系自然、经典商务
- **可扩展皮肤系统** - 基于接口设计，轻松添加新皮肤

## 皮肤预览

| 皮肤 | 风格 |
|------|------|
| 多巴胺 | 高饱和亮色系，充满活力 |
| 赛博朋克 | 深色霓虹灯配色，科技感 |
| 莫兰迪 | 低饱和度柔和配色，高级感 |
| 森系自然 | 绿色大地色系，清新宁静 |
| 经典商务 | 黑白灰简约，专业大气 |

## 技术栈

- Flutter 3.x + Dart
- Provider 状态管理
- SharedPreferences 本地持久化
- http 网络请求

## 构建

```bash
flutter pub get
flutter build apk --release
```

## 皮肤扩展

实现 `CalculatorSkin` 接口，注册到 `SkinManager` 即可添加新皮肤：

```dart
class MyNewSkin implements CalculatorSkin {
  // 实现所有属性...
}

// 在 SkinManager 中注册
skinManager.registerSkin(MyNewSkin());
```
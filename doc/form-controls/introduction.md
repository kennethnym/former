# Introduction

`former` comes with a bunch of form controls that can be used to modify a form. All of them are simple wrappers around
common Flutter widgets that are used to build forms:

- `FormerTextField` wraps `TextField`
- `FormerCheckbox` wraps `Checkbox`
- etc.

All former controls accepts arguments for the constructor of the widget that they wrap. For example, The constructor
of`FormerTextField` has the same set of parameters as `TextField`.

## Enabling/disabling controls

By default, all former controls follow whether the form in context is disabled. If the form is disabled, then all the
former controls that control the form are disabled as well.

You can override this behavior by passing in a value for the `enabled` parameter.

## List of controls

Below are a list of controls that are currently available. They are links to API references of the former controls.

- `FormerCheckbox` ([docs](https://pub.dev/documentation/former/latest/former/FormerCheckbox-class.html))
- `FormerSlider` ([docs](https://pub.dev/documentation/former/latest/former/FormerSlider-class.html))
- `FormerSwitch` ([docs](https://pub.dev/documentation/former/latest/former/FormerSwitch-class.html))
- `FormerTextField` ([docs](https://pub.dev/documentation/former/latest/former/FormerTextField-class.html))

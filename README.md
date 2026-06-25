# MegaDetector ONNX

ONNX model building for MegaDetector v1000 Redwood.

This builds two ONNX exports from the official `MDv1000-redwood` checkpoint:

- `models/md_v1000.0.0-redwood-dynamic.onnx`
- `models/md_v1000.0.0-redwood-1280x1280.onnx`

Run:

```sh
./build
```

The source checkpoint is downloaded from the `agentmorris/MegaDetector` `v1000.0` release. Redwood is a YOLOv5x6 model with a 1280 pixel input size.

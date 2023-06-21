#!/usr/bin/env sh

# Configuration
XCODE_TEMPLATE_DIR=$HOME'/Library/Developer/Xcode/Templates/File Templates/Template'
VIEWMODEL_TEMPLATE_DIR="$XCODE_TEMPLATE_DIR""/Templates/ViewModel.xctemplate"
COORDINATOR_TEMPLATE_DIR="$XCODE_TEMPLATE_DIR""/Templates/Coordinator.xctemplate"
USECASE_TEMPLATE_DIR="$XCODE_TEMPLATE_DIR""/Templates/UseCase.xctemplate"
GATEWAY_TEMPLATE_DIR="$XCODE_TEMPLATE_DIR""/Templates/Gateway.xctemplate"
REQUEST_TEMPLATE_DIR="$XCODE_TEMPLATE_DIR""/Templates/Request.xctemplate"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Copy Unio file templates into the local Unio template directory
xcodeTemplate () {
  echo "==> Copying up Unio Xcode file templates..."

  if [ -d "$XCODE_TEMPLATE_DIR" ]; then
    rm -R "$XCODE_TEMPLATE_DIR"
  fi
  mkdir -p "$XCODE_TEMPLATE_DIR"

  cp -R $SCRIPT_DIR"/Templates/ViewModel.xctemplate" "$XCODE_TEMPLATE_DIR"
  cp -R $SCRIPT_DIR"/Templates/Coordinator.xctemplate" "$XCODE_TEMPLATE_DIR"
  cp -R $SCRIPT_DIR"/Templates/UseCase.xctemplate" "$XCODE_TEMPLATE_DIR"
  cp -R $SCRIPT_DIR"/Templates/Gateway.xctemplate" "$XCODE_TEMPLATE_DIR"
  cp -R $SCRIPT_DIR"/Templates/Request.xctemplate" "$XCODE_TEMPLATE_DIR"
}

xcodeTemplate

echo "==> ... success!"


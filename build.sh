#!/bin/bash -ex

# To create system user:
# snap install make-system-user --classic
# make-system-user --brand gkYZ6UKpOGdP5Gb6zjGdgcIxCo0xKsmd --model niryodemo --username niryodemo --password dem0Niry0 --key niryodemo

ubuntu-image snap \
             --snap ../niryo-arm-gadget/niryo-arm_16.04-0.7_armhf.snap \
             --snap abeato-niryo-one=edge \
             --snap niryo-sequence \
             --hooks-directory hooks \
             niryo-model.assert

# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.

NAME_DATA="cuhk03labeled"
NAME_MODEL="resnet50_rga"
BATCH_SIZE=64
NUM_WORKER=8
NUM_FEATURE=2048
NUM_GPU=1
SEED=16
START_SAVE=320
BRANCH_NAME="rgasc"

DATA_DIR="./datasets"
LOG_DIR="./logs/RGA-SC/cuhk03labeled_b64f2048"

if [ -d ${LOG_DIR} ]; then
	rm -r ${LOG_DIR}
fi

if [ ! -d ${LOG_DIR} ]; then
	echo ${LOG_DIR}" does not exist!"
	mkdir -p ${LOG_DIR}
fi

echo "Begin to test."
LOG_FILE_TEST="${LOG_DIR}/eval.txt"
CUDA_VISIBLE_DEVICES=0 python main_imgreid.py \
	-a ${NAME_MODEL} \
	-b ${BATCH_SIZE} \
	-d ${NAME_DATA} \
	-j ${NUM_WORKER} \
	--combine-trainval \
	--start_save ${START_SAVE} \
	--seed ${SEED} \
	--num_gpu ${NUM_GPU} \
	--features ${NUM_FEATURE} \
	--branch_name ${BRANCH_NAME} \
	--data-dir ${DATA_DIR} \
	--logs-dir ${LOG_DIR} \
	--evaluate \
	2>&1 | tee ${LOG_FILE_TEST}
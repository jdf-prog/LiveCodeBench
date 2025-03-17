mkdir -p logs
python -m lcb_runner.runner.main --model /data/dongfu/verl/checkpoints/acecoder/qwen_qwen2.5-7b-instruct-grpo-n8-b512-t1.2/global_step_20/actor/huggingface --scenario codegeneration --evaluate --release_version v4_v5 --tensor_parallel_size 4 > ./logs/eval_acecoder_on_v4_v5.log

python -m lcb_runner.runner.main --model Qwen/Qwen2.5-7B-Instruct --scenario codegeneration --evaluate --release_version v4_v5 --tensor_parallel_size 4 > ./logs/eval_qwen2.5-7b-instruct_on_v4_v5.log

python -m lcb_runner.runner.main --model Qwen/Qwen2.5-Coder-7B-Instruct --scenario codegeneration --evaluate --release_version v4_v5 --tensor_parallel_size 2 > ./logs/eval_qwen2.5-coder-7b-instruct_on_v4_v5.log


python -m lcb_runner.runner.main --model /data/dongfu/verl/checkpoints/acecoder/qwen_qwen2.5-7b-instruct-grpo-n8-b512-t1.2/global_step_20/actor/huggingface --scenario codegeneration --evaluate --release_version v4 --tensor_parallel_size 4 > ./logs/eval_acecoder_on_v4.log

python -m lcb_runner.runner.main --model Qwen/Qwen2.5-7B-Instruct --scenario codegeneration --evaluate --release_version v4 --tensor_parallel_size 4 > ./logs/eval_qwen2.5-7b-instruct_on_v4.log

python -m lcb_runner.runner.main --model Qwen/Qwen2.5-Coder-7B-Instruct --scenario codegeneration --evaluate --release_version v4 --tensor_parallel_size 2 > ./logs/eval_qwen2.5-coder-7b-instruct_on_v4.log


python -m lcb_runner.runner.main --model /data/dongfu/verl/checkpoints/acecoder/qwen_qwen2.5-7b-instruct-grpo-n8-b512-t1.2/global_step_20/actor/huggingface --scenario codegeneration --evaluate --release_version v5 --tensor_parallel_size 4 > ./logs/eval_acecoder_on_v5.log

python -m lcb_runner.runner.main --model Qwen/Qwen2.5-7B-Instruct --scenario codegeneration --evaluate --release_version v5 --tensor_parallel_size 4 > ./logs/eval_qwen2.5-7b-instruct_on_v5.log

python -m lcb_runner.runner.main --model Qwen/Qwen2.5-Coder-7B-Instruct --scenario codegeneration --evaluate --release_version v5 --tensor_parallel_size 2 > ./logs/eval_qwen2.5-coder-7b-instruct_on_v5.log
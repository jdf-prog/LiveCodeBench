model=deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B
n=1
export DEEPSEEK_R1_NO_SYS_PROMPT=1
max_tokens=32768
top_p=0.95
temperature=0.6
python -m lcb_runner.runner.main --model $model --tensor_parallel_size 4 --scenario codegeneration --evaluate --release_version 'v4_v5' --top_p $top_p --temperature $temperature --max_tokens=$max_tokens  --n $n --codegen_n $n --num_process_evaluate 32

model=agentica-org/DeepCoder-14B-Preview
n=1
export DEEPSEEK_R1_NO_SYS_PROMPT=1
max_tokens=64000
top_p=0.95
temperature=0.6
python -m lcb_runner.runner.main --model $model --tensor_parallel_size 4 --scenario codegeneration --evaluate --release_version 'v4_v5' --top_p $top_p --temperature $temperature --max_tokens=$max_tokens  --n $n --codegen_n $n --num_process_evaluate 32

model=deepseek-ai/DeepSeek-R1-Distill-Qwen-14B
n=8
export DEEPSEEK_R1_NO_SYS_PROMPT=0
max_tokens=32768
top_p=0.95
temperature=0.6
python -m lcb_runner.runner.main --model $model --tensor_parallel_size 4 --scenario codegeneration --evaluate --release_version 'v4_v5' --top_p $top_p --temperature $temperature --max_tokens=$max_tokens  --n $n --codegen_n $n --num_process_evaluate 32
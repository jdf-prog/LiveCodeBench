### Code Generation
```bash
python -m lcb_runner.runner.main --model Qwen/Qwen2.5-Coder-7B-Instruct --scenario codegeneration --evaluate --start_date 2024-08-01 --end_date 2024-11-01
```
```
0.1536144578313253
```


```bash
python -m lcb_runner.runner.main --model Qwen/Qwen2.5-Coder-7B-Instruct --scenario selfrepair --evaluate --continue_existing --codegen_n 10 --n 1  --start_date 2024-08-01 --end_date 2024-11-01
```
```
0.1819277108433735
```
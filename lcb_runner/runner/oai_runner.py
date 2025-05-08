import os
from time import sleep

try:
    import openai
    from openai import OpenAI
except ImportError as e:
    pass

from lcb_runner.lm_styles import LMStyle
from lcb_runner.runner.base_runner import BaseRunner

system_prompt1 = """A conversation between User and Assistant. The user asks a question, and the Assistant solves it. The assistant first thinks about the reasoning process in the mind and then provides the user with the answer. User: Please integrate natural language reasoning with programs to solve the coding problems below. If you want to test any python code, writing it inside <python> and </python> tags following with <output>. Please put your final answer in a markdown code block like this: python\nyour code here\n``` without appending anything.
"""

system_prompt2 = """A conversation between User and Assistant. The user asks a question, and the Assistant solves it. The assistant first thinks about the reasoning process in the mind and then provides the user with the answer. User: Please integrate natural language reasoning with programs to solve the coding problems below. If the you want to run any python code, execution result will be in the output markdown block like "```output\nexecution result here\n```" following the code block. Please put your final answer in a markdown code block like this: python\nyour code here\n``` without appending anything.
"""

system_prompt3 = """A conversation between User and Assistant. The user asks a question, and the Assistant solves it. The assistant first thinks about the reasoning process in the mind and then provides the user with the answer. User: Please solve the coding problems below and put your final answer in a markdown code block like this: python\nyour code here\n``` without appending anything.
"""


class OpenAIRunner(BaseRunner):
    client = OpenAI(
        api_key=os.getenv("OPENAI_KEY")
    )

    def __init__(self, args, model):
        super().__init__(args, model)
        if model.model_style == LMStyle.OpenAIReasonPreview:
            self.client_kwargs: dict[str | str] = {
                "model": args.model,
                "max_completion_tokens": 25000,
            }
        elif model.model_style == LMStyle.OpenAIReason:
            assert (
                "__" in args.model
            ), f"Model {args.model} is not a valid OpenAI Reasoning model as we require reasoning effort in model name."
            model, reasoning_effort = args.model.split("__")
            self.client_kwargs: dict[str | str] = {
                "model": model,
                "reasoning_effort": reasoning_effort,
            }
        else:
            self.client_kwargs: dict[str | str] = {
                "model": args.model,
                "temperature": args.temperature,
                "max_tokens": args.max_tokens,
                "top_p": args.top_p,
                "frequency_penalty": 0,
                "presence_penalty": 0,
                "n": args.n,
                "timeout": args.openai_timeout,
                # "stop": args.stop, --> stop is only used for base models currently
            }

    def _run_single(self, prompt: list[dict[str, str]]) -> list[str]:
        assert isinstance(prompt, list)
        system_prompt = None
        roles = [message["role"] for message in prompt]
        assert roles.count("user") == 1, "There should be only one user message in the prompt."
        for message in prompt:
            if message["role"] == "system":
                system_prompt = message["content"]
            if message["role"] == "user":
                user_prompt = message["content"]
        system_prompt = system_prompt3 # verltool: change system prompt here
        try:
            # response = OpenAIRunner.client.chat.completions.create(
            #     messages=prompt,
            #     **self.client_kwargs,
            # )
            # result = [c.message.content for c in response.choices]
            prompt = f"system\n{system_prompt}\n\nuser\n{user_prompt}\nassistant\n"
            response = OpenAIRunner.client.completions.create(
                prompt=prompt,
                **self.client_kwargs,
            )
            result = [choice.text for choice in response.choices]
        except (
            openai.APIError,
            openai.RateLimitError,
            openai.InternalServerError,
            openai.OpenAIError,
            openai.APIStatusError,
            openai.APITimeoutError,
            openai.InternalServerError,
            openai.APIConnectionError,
        ) as e:
            print("Exception: ", repr(e))
            print("Sleeping for 30 seconds...")
            print("Consider reducing the number of parallel processes.")
            sleep(30)
            return self._run_single(prompt)
        except Exception as e:
            print(f"Failed to run the model for {prompt}!")
            print("Exception: ", repr(e))
            raise e
        return result

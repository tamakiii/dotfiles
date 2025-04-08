# GitHub Copilot Customization Files

This directory contains custom instruction files for GitHub Copilot Chat to personalize its behavior for different tasks.

## Documentation Resources

* [GitHub Copilot Customization Guide](https://code.visualstudio.com/docs/copilot/copilot-customization)
* [GitHub Copilot Settings Reference](https://code.visualstudio.com/docs/copilot/reference/copilot-settings)
* [GitHub Copilot Chat Documentation](https://docs.github.com/en/copilot/github-copilot-chat/using-github-copilot-chat)

## VS Code Settings Configuration

Add the following to your VS Code `settings.json` file to enable custom instructions:

```json
{
    // ...
    "github.copilot.nextEditSuggestions.enabled": true,
    "github.copilot.chat.codeGeneration.instructions": [
        {
            "file":"~/.llm/prompt/github-copilot/.copilot-codeGeneration-instructions.md",
        },
        {
            "file":".copilot-codeGeneration-instructions.md"
        }
    ],
    "github.copilot.chat.testGeneration.instructions": [
        {
            "file":"~/.llm/prompt/github-copilot/.copilot-testGeneration-instructions.md",
        },
        {
            "file": ".copilot-testGeneration-instructions.md"
        }
    ],
    "github.copilot.chat.reviewSelection.instructions": [
        {
            "file":"~/.llm/prompt/github-copilot/.copilot-review-instructions.md",
        },
        {
            "file": ".copilot-review-instructions.md"
        }
    ],
    "github.copilot.chat.commitMessageGeneration.instructions": [
        {
            "file":"~/.llm/prompt/github-copilot/.copilot-commitMessageGeneration-instructions.md",
        },
        {
            "file": ".copilot-commitMessageGeneration-instructions.md"
        }
    ],
    "github.copilot.chat.generateTests.codeLens": true
}
```

## Instruction Files Overview

This directory contains the following instruction files:

1. `.copilot-codeGeneration-instructions.md` - Guides how Copilot generates code in chat
2. `.copilot-testGeneration-instructions.md` - Customizes test generation behavior
3. `.copilot-review-instructions.md` - Defines code review style and focus areas
4. `.copilot-commitMessageGeneration-instructions.md` - Formats commit message generation

## Usage

After configuring the settings above, GitHub Copilot will use your custom instructions for different operations. You can modify each instruction file to align with your coding preferences, style guidelines, and project requirements.

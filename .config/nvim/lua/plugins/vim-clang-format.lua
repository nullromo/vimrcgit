return function()
    return {
        'rhysd/vim-clang-format',
        init = function ()
            -- Set options for clang-format in case there is no .clang-format file
            -- Note: BreakBeforeBraces: Attach doesn't attach enum braces
            -- Note: IndentGotoLabels: true doesn't indent properly within switch
            vim.g['clang_format#style_options'] = {
                AccessModifierOffset = -2,
                AlignAfterOpenBracket = "Align",
                AlignConsecutiveAssignments = "false",
                AlignConsecutiveBitFields = "true",
                AlignConsecutiveDeclarations = "false",
                AlignConsecutiveMacros = "true",
                AlignEscapedNewlines = "Left",
                AlignOperands = "Align",
                AlignTrailingComments = "true",
                AllowAllArgumentsOnNextLine = "true",
                AllowAllConstructorInitializersOnNextLine = "false",
                AllowAllParametersOfDeclarationOnNextLine = "true",
                AllowShortBlocksOnASingleLine = "Never",
                AllowShortCaseLabelsOnASingleLine = "false",
                AllowShortEnumsOnASingleLine = "false",
                AllowShortFunctionsOnASingleLine = "None",
                AllowShortIfStatementsOnASingleLine = "Never",
                AllowShortLambdasOnASingleLine = "None",
                AllowShortLoopsOnASingleLine = "false",
                AlwaysBreakAfterReturnType = "None",
                AlwaysBreakBeforeMultilineStrings = "true",
                AlwaysBreakTemplateDeclarations = "No",
                BinPackArguments = "false",
                BinPackParameters = "false",
                BreakBeforeBinaryOperators = "None",
                BreakBeforeBraces = "Attach",
                BreakBeforeTernaryOperators = "false",
                BreakConstructorInitializers = "BeforeColon",
                BreakInheritanceList = "BeforeColon",
                BreakStringLiterals = "true",
                ColumnLimit = 80,
                CompactNamespaces = "false",
                ConstructorInitializerAllOnOneLineOrOnePerLine = "true",
                ConstructorInitializerIndentWidth = 4,
                ContinuationIndentWidth = 8,
                Cpp11BracedListStyle = "true",
                DeriveLineEnding = "true",
                DerivePointerAlignment = "false",
                DisableFormat = "false",
                FixNamespaceComments = "true",
                IncludeBlocks = "Merge",
                IndentCaseBlocks = "true",
                IndentCaseLabels = "true",
                IndentExternBlock = "Indent",
                IndentGotoLabels = "true",
                IndentPPDirectives = "AfterHash",
                IndentWidth = 4,
                IndentWrappedFunctionNames = "false",
                KeepEmptyLinesAtTheStartOfBlocks = "false",
                Language = "Cpp",
                MaxEmptyLinesToKeep = 1,
                NamespaceIndentation = "All",
                PenaltyReturnTypeOnItsOwnLine = 999,
                PointerAlignment = "Left",
                ReflowComments  = "true",
                SortIncludes = "true",
                SortUsingDeclarations = "true",
                SpaceAfterCStyleCast = "false",
                SpaceAfterLogicalNot = "false",
                SpaceAfterTemplateKeyword = "false",
                SpaceBeforeAssignmentOperators = "true",
                SpaceBeforeCpp11BracedList = "true",
                SpaceBeforeCtorInitializerColon = "true",
                SpaceBeforeInheritanceColon = "true",
                SpaceBeforeParens = "ControlStatements",
                SpaceBeforeRangeBasedForLoopColon = "false",
                SpaceBeforeSquareBrackets = "false",
                SpaceInEmptyBlock = "false",
                SpaceInEmptyParentheses = "false",
                SpacesBeforeTrailingComments = 1,
                SpacesInAngles = "false",
                SpacesInCStyleCastParentheses = "false",
                SpacesInConditionalStatement = "false",
                SpacesInContainerLiterals = "false",
                SpacesInParentheses = "false",
                SpacesInSquareBrackets = "false",
                Standard = "Cpp11",
                TabWidth = 4,
                UseCRLF = "false",
                UseTab = "Never"
            }
        end,
        config = function ()
            -- Autoformat C and C++ files on save
            vim.api.nvim_create_autocmd({ 'WinEnter', 'FileType' }, {
                callback = function()
                    local ft = vim.bo.filetype
                    if ft == 'cpp' or ft == 'c' then
                        vim.notify('clang enabled')
                        vim.cmd('ClangFormatAutoEnable')
                    else
                        vim.notify('clang disabled')
                        vim.cmd('ClangFormatAutoDisable')
                    end
                end,
            })
        end,
        ft = {
            'c',
            'cpp',
        },
    }
end

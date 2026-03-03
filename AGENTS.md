# Agent Guidelines for OpenHarmony ArkTS Project

This document provides guidelines for AI agents working on this OpenHarmony ArkTS project. The project uses the HarmonyOS application framework with ArkTS (TypeScript-like language) and the hvigor build system.

## Project Structure

- `AppScope/` – Application-level resources and configuration
- `entry/` – Main module (HAP)
  - `src/main/ets/` – ArkTS source code
    - `entryability/` – UIAbility lifecycle
    - `pages/` – UI components (structs)
    - `common/` – Shared constants and utilities
    - `storage/` – Data persistence
  - `src/ohosTest/ets/test/` – System test cases (hypium)
  - `src/test/` – Unit test cases (hypium)
- `oh_modules/` – OpenHarmony npm packages (OHPM)
- `hvigor/` – Build configuration
- `build-profile.json5` – Build profiles and signing
- `code-linter.json5` – ESLint configuration

## Build System

The project uses **hvigor** (HarmonyOS build tool). Hvigor tasks are defined in `hvigorfile.ts`. Common commands (run from project root):

```bash
# Build the project (requires hvigor installed globally or via DevEco Studio)
hvigor build

# Clean build outputs
hvigor clean

# Run linting (ESLint)
hvigor lint

# Execute unit tests (hypium)
hvigor test --module entry

# Execute system tests (ohosTest)
hvigor test --module entry --test-type ohosTest
```

If hvigor is not installed globally, use the wrapper script `hvigorw` (if present) or run via DevEco Studio.

## Testing

The test framework is **Hypium** (OpenHarmony unit test framework). Tests are located in `entry/src/ohosTest/` (system tests) and `entry/src/test/` (unit tests).

### Running a Single Test

To run a specific test suite or test case, use the `-s` flag with the `class` filter:

```bash
hvigor test --module entry -s class "AbilityTest#assertContain"
```

The filter format is `describeName#itName`. Multiple tests can be separated by commas.

### Test Structure

- Test files are named `*.test.ets`
- Use `describe` to define a test suite and `it` for individual cases
- Import `{ describe, it, expect, ... } from '@ohos/hypium'`
- Use `hilog` for logging within tests

Example test:
```ets
import { describe, it, expect } from '@ohos/hypium';

export default function abilityTest() {
  describe('ActsAbilityTest', () => {
    it('assertContain', 0, () => {
      let a = 'abc';
      let b = 'b';
      expect(a).assertContain(b);
    });
  });
}
```

### Test Attributes

Tests can be tagged with `Level`, `Size`, and `TestType` for selective execution:

```ets
it("testAttribute", TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => { ... });
```

## Code Style

The project uses ESLint with the following rule sets (configured in `code-linter.json5`):

- `plugin:@performance/recommended`
- `plugin:@typescript-eslint/recommended`

Additional security rules are enforced (e.g., `@security/no-unsafe-aes`). Run `hvigor lint` to check compliance.

### Import Order

1. External HarmonyOS kits (`@kit.*`)
2. External OHPM packages
3. Internal relative imports (use `'../'` or `'./'`)

Example:
```ets
import { relationalStore } from '@kit.ArkData';
import { hilog } from '@kit.PerformanceAnalysisKit';
import CommonConstants from '../common/constants/CommonConstants';
```

### Naming Conventions

- **Classes**: `PascalCase` (e.g., `EntryAbility`, `RDBStoreUtil`)
- **Variables and functions**: `camelCase` (e.g., `mainRDBStore`, `createRDB`)
- **Constants**: `UPPER_SNAKE_CASE` for primitive values (e.g., `TAG`, `DOMAIN`, `STORE_CONFIG`)
- **File names**: `PascalCase` for components and classes, `camelCase` for utilities (e.g., `Home.ets`, `RDBStoreUtil.ets`)
- **Directory names**: `camelCase` (e.g., `entryability`, `common`)

### Type Annotations

Always provide explicit types for function parameters, return types, and variable declarations:

```ets
private mainRDBStore?: relationalStore.RdbStore;

createRDB(context: Context): void {
  const STORE_CONFIG: relationalStore.StoreConfig = { ... };
}
```

Use `?` for optional properties and `|` for union types.

### Error Handling

- Use `try`/`catch` for synchronous errors and `.catch()` for promises.
- Log errors with `hilog.error()` including error code and message.
- Use the `BusinessError` type for API errors.

Example:
```ets
try {
  await this.mainRDBStore?.insert(...);
} catch (err) {
  hilog.error(0x0000, TAG, `insert failed, code is ${err.code}, message is ${err.message}`);
}
```

### Logging

- Use `hilog` from `@kit.PerformanceAnalysisKit`.
- Define a `DOMAIN` constant (usually `0x0000`) and a `TAG` string for component identification.
- Use appropriate log levels: `info`, `debug`, `warn`, `error`.
- For public data use `%{public}s`; for private data use `%{private}s`.

Example:
```ets
const DOMAIN = 0x0000;
const TAG = 'EntryAbility';

hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onCreate');
```

### UI Components (ArkTS)

- Use `@Component` and `@Preview` decorators.
- Struct names are `PascalCase` and default‑exported.
- Use `@State`, `@Link`, `@Prop` decorators for state management.
- Prefer inline lambdas for event handlers (`onClick(() => { ... })`).

Example:
```ets
@Preview
@Component
export default struct Home {
  @State message: string = 'Hello';

  build() {
    Text(this.message)
      .onClick(() => {
        this.message = 'Clicked';
      })
  }
}
```

## Security Rules

The ESLint configuration includes strict security rules that prohibit unsafe cryptographic APIs. Ensure any new code does not trigger these rules (errors include `@security/no-unsafe-aes`, `@security/no-unsafe-hash`, etc.). If a security‑sensitive API is required, consult the project maintainers.

## Development Workflow

1. **Before making changes**, run `hvigor lint` to ensure code style compliance.
2. **Write tests** for new functionality in the appropriate test directory (`ohosTest` for system‑level tests, `test` for unit tests).
3. **Run tests** with `hvigor test --module entry` and verify all pass.
4. **Build the project** with `hvigor build` to catch any compilation errors.
5. **Commit messages** should follow conventional commits (feat, fix, chore, etc.).

## CI/CD

No CI/CD configuration is present in the repository. However, the project may be built and tested via DevEco Studio or a custom pipeline using hvigor commands.

## Editor Configuration

- **DevEco Studio** is the recommended IDE for HarmonyOS development.
- **ESLint** integration is provided by the `code-linter.json5` configuration.
- No `.prettierrc` or `.editorconfig` files are present; formatting is handled by the IDE.

## Cursor / Copilot Rules

No `.cursorrules`, `.cursor/`, or `.github/copilot-instructions.md` files exist in the repository. Agents should follow the guidelines in this document.

---

*This file is maintained for AI agents working on the project. Update it as the project evolves.*
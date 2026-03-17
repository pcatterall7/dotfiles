const { Plugin } = require('obsidian');

module.exports = class FoldH2Plugin extends Plugin {
  async onload() {
    this.addCommand({
      id: 'fold-all-to-h2',
      name: 'Fold all H2 headings',
      checkCallback: (checking) => {
        const view = this.app.workspace.getActiveViewOfType(require('obsidian').MarkdownView);
        if (!view) return false;
        if (checking) return true;

        const existingFolds = view.currentMode.getFoldInfo()?.folds ?? [];

        const headings = this.app.metadataCache.getFileCache(view.file)?.headings ?? [];
        const h2Headings = headings.filter(h => h.level === 2);

        const h2LineNums = new Set(h2Headings.map(h => h.position.start.line));

        // Merge existing non-H2 folds with new H2 folds
        const newFolds = [
          ...existingFolds.filter(f => !h2LineNums.has(f.from)),
          ...h2Headings.map(h => ({
            from: h.position.start.line,
            to: h.position.start.line + 1,
          })),
        ];

        view.currentMode.applyFoldInfo({
          folds: newFolds,
          lines: view.editor.lineCount(),
        });
        view.onMarkdownFold();
      }
    });
  }
};

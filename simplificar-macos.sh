#!/bin/bash

echo "🔧 Simplificando macOS para melhor estabilidade com NootedRed..."

# Desabilitar animações de janela
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Desabilitar animações de abertura de apps
defaults write com.apple.dock launchanim -bool false

# Desabilitar animações do Mission Control
defaults write com.apple.dock expose-animation-duration -float 0

# Desabilitar transparência (efeito vidro)
defaults write com.apple.universalaccess reduceTransparency -bool true

# Desabilitar movimentos automáticos (parallax, etc.)
defaults write com.apple.universalaccess reduceMotion -bool true

# Desabilitar animações de redesimensionamento
defaults write -g NSWindowResizeTime -float 0.001

# Desabilitar animações do Quick Look
defaults write -g QLPanelAnimationDuration -float 0

# Desabilitar animações de popups de info
defaults write com.apple.finder DisableAllAnimations -bool true

# Desabilitar animações da barra de ferramentas
defaults write com.apple.finder NSToolbarTitleViewRolloverDelay -float 0

# Matar o Dock para aplicar as mudanças
killall Dock

echo "✅ Feito! Reinicie o Mac para que todas as mudanças tenham efeito."
echo ""
echo "💡 Dica: Para reverter no futuro, execute:"
echo "   defaults delete com.apple.dock launchanim"
echo "   defaults delete com.apple.universalaccess reduceTransparency"
echo "   defaults delete com.apple.universalaccess reduceMotion"
echo "   killall Dock"

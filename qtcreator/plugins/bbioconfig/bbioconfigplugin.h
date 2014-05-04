#ifndef BBIOCONFIG_H
#define BBIOCONFIG_H

#include "bbioconfig_global.h"

#include <extensionsystem/iplugin.h>

namespace BBIOConfig {
namespace Internal {

class BBIOConfigFactory;

class BBIOConfigPlugin : public ExtensionSystem::IPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QtCreatorPlugin" FILE "BBIOConfig.json")

public:
    BBIOConfigPlugin();
    ~BBIOConfigPlugin();

    bool initialize(const QStringList &arguments, QString *errorString);
    void extensionsInitialized();
    ShutdownFlag aboutToShutdown();

private slots:
    void triggerAction();

private:
    QPointer<BBIOConfigFactory> m_factory;
};

} // namespace Internal
} // namespace BBIOConfig

#endif // BBIOCONFIG_H


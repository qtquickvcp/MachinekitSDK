#include "bbioconfigfactory.h"
#include "bbioconfigconstants.h"
#include "bbioconfig.h"

#include <QCoreApplication>
#include <QMap>
#include <QDebug>

namespace BBIOConfig {
namespace Internal {

BBIOConfigFactory::BBIOConfigFactory(QObject *parent) :
    Core::IEditorFactory(parent)
{
    setId(Constants::BBIOCONFIG_ID);
    setDisplayName(qApp->translate("OpenWith::Editors", Constants::BBIOCONFIG_DISPLAY_NAME));

    addMimeType("text/x-bbio");
}

Core::IEditor *BBIOConfigFactory::createEditor()
{
    return new BBIOConfig();
}

void BBIOConfigFactory::extensionsInitialized()
{
    m_actionHandler.createActions();
}

} // namespace Internal
} // namespace BBIOConfig

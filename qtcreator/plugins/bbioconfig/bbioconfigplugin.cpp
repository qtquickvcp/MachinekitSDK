#include "bbioconfigplugin.h"
#include "bbioconfigfactory.h"
#include "bbioconfigconstants.h"

#include <coreplugin/icore.h>
#include <coreplugin/icontext.h>
#include <coreplugin/actionmanager/actionmanager.h>
#include <coreplugin/actionmanager/command.h>
#include <coreplugin/actionmanager/actioncontainer.h>
#include <coreplugin/coreconstants.h>
#include <coreplugin/mimedatabase.h>
#include <coreplugin/id.h>
#include <extensionsystem/pluginmanager.h>

#include <QAction>
#include <QMessageBox>
#include <QMainWindow>
#include <QMenu>

#include <QtPlugin>

namespace BBIOConfig {
namespace Internal {

///////////////////////////////// BBIOConfigPlugin //////////////////////////////////

BBIOConfigPlugin::BBIOConfigPlugin()
{
    // Create your members
}

BBIOConfigPlugin::~BBIOConfigPlugin()
{
    // Unregister objects from the plugin manager's object pool
    // Delete members
}

bool BBIOConfigPlugin::initialize(const QStringList &arguments, QString *errorMessage)
{
    // Register objects in the plugin manager's object pool
    // Load settings
    // Add actions to menus
    // Connect to other plugins' signals
    // In the initialize function, a plugin can be sure that the plugins it
    // depends on have initialized their members.

    Q_UNUSED(arguments)

   /* QAction *action = new QAction(tr("BBIOConfig action"), this);
    Core::Command *cmd = Core::ActionManager::registerAction(action, Constants::ACTION_ID,
                                                             Core::Context(Core::Constants::C_GLOBAL));
    cmd->setDefaultKeySequence(QKeySequence(tr("Ctrl+Alt+Meta+A")));
    connect(action, SIGNAL(triggered()), this, SLOT(triggerAction()));

    Core::ActionContainer *menu = Core::ActionManager::createMenu(Constants::MENU_ID);
    menu->menu()->setTitle(tr("BBIOConfig"));
    menu->addAction(cmd);
    Core::ActionManager::actionContainer(Core::Constants::M_TOOLS)->addMenu(menu);
*/

    if (!Core::MimeDatabase::addMimeTypes(QLatin1String(":/bbioconfig/BBIOConfig.mimetypes.xml"), errorMessage))
            return false;

    m_factory = new BBIOConfigFactory(this);
    Aggregation::Aggregate *aggregate = new Aggregation::Aggregate;
    aggregate->add(m_factory);

    addAutoReleasedObject(m_factory);
    return true;
}

void BBIOConfigPlugin::extensionsInitialized()
{
    // Retrieve objects from the plugin manager's object pool
    // In the extensionsInitialized function, a plugin can be sure that all
    // plugins that depend on it are completely initialized.
    m_factory->extensionsInitialized();
}

ExtensionSystem::IPlugin::ShutdownFlag BBIOConfigPlugin::aboutToShutdown()
{
    // Save settings
    // Disconnect from signals that are not needed during shutdown
    // Hide UI (if you add UI that is not in the main window directly)
    return SynchronousShutdown;
}

void BBIOConfigPlugin::triggerAction()
{
    QMessageBox::information(Core::ICore::mainWindow(),
                             tr("Action triggered"),
                             tr("This is an action from BBIOConfig."));
}

} // namespace Internal
} // namespace BBIOConfig

//Q_EXPORT_PLUGIN2(BBIOConfig, BBIOConfigPlugin)


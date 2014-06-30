#include "bbioconfigactionhandler.h"
#include "bbioconfig.h"
#include "bbioconfigconstants.h"

#include <coreplugin/icore.h>
#include <coreplugin/actionmanager/actionmanager.h>
#include <coreplugin/actionmanager/command.h>
#include <coreplugin/editormanager/editormanager.h>
#include <coreplugin/id.h>

#include <QAction>
#include <QList>
#include <QSignalMapper>

namespace BBIOConfig {
namespace Internal {

enum SupportedActions {
    ZoomIn = 0,
    ZoomOut,
    OriginalSize,
    FitToScreen,
    Background,
    Outline,
    ToggleAnimation
};

BBIOConfigActionHandler::BBIOConfigActionHandler(QObject *parent):
    QObject(parent), m_signalMapper(new QSignalMapper(this))
{
    connect(m_signalMapper, SIGNAL(mapped(int)), SLOT(actionTriggered(int)));
}

void BBIOConfigActionHandler::createActions()
{
/*    registerNewAction(ZoomIn, Constants::ACTION_ZOOM_IN, tr("Zoom In"),
                      QKeySequence(tr("Ctrl++")));
    registerNewAction(ZoomOut, Constants::ACTION_ZOOM_OUT, tr("Zoom Out"),
                      QKeySequence(tr("Ctrl+-")));
    registerNewAction(OriginalSize, Constants::ACTION_ORIGINAL_SIZE, tr("Original Size"),
                      QKeySequence(Core::UseMacShortcuts ? tr("Meta+0") : tr("Ctrl+0")));
    registerNewAction(FitToScreen, Constants::ACTION_FIT_TO_SCREEN, tr("Fit To Screen"),
                      QKeySequence(tr("Ctrl+=")));
    registerNewAction(Background, Constants::ACTION_BACKGROUND, tr("Switch Background"),
                      QKeySequence(tr("Ctrl+[")));
    registerNewAction(Outline, Constants::ACTION_OUTLINE, tr("Switch Outline"),
                      QKeySequence(tr("Ctrl+]")));
    registerNewAction(ToggleAnimation, Constants::ACTION_TOGGLE_ANIMATION, tr("Toggle Animation"),
                      QKeySequence());
                      */
}

void BBIOConfigActionHandler::actionTriggered(int supportedAction)
{
    Core::IEditor *editor = Core::EditorManager::currentEditor();
    BBIOConfig *viewer = qobject_cast<BBIOConfig *>(editor);
    if (!viewer)
        return;

    SupportedActions action = static_cast<SupportedActions>(supportedAction);
    switch (action) {
    case ZoomIn:
        //viewer->zoomIn();
        break;
    case ZoomOut:
        //viewer->zoomOut();
        break;
    case OriginalSize:
        //viewer->resetToOriginalSize();
        break;
    case FitToScreen:
        //viewer->fitToScreen();
        break;
    case Background:
        //viewer->switchViewBackground();
        break;
    case Outline:
        //viewer->switchViewOutline();
        break;
    case ToggleAnimation:
        //viewer->togglePlay();
        break;
    default:
        break;
    }
}

/*!
    Creates a new action with the internal id \a actionId, command id \a id,
    and keyboard shortcut \a key, and registers it in the action manager.
*/

void BBIOConfigActionHandler::registerNewAction(int actionId, const Core::Id &id, const QString &title, const QKeySequence &key)
{
    Core::Context context(Constants::BBIOCONFIG_ID);
    QAction *action = new QAction(title, this);
    Core::Command *command = Core::ActionManager::registerAction(action, id, context);
    command->setDefaultKeySequence(key);
    connect(action, SIGNAL(triggered()), m_signalMapper, SLOT(map()));
    m_signalMapper->setMapping(action, actionId);
}


} // namespace Internal
} // namespace BBIOConfig

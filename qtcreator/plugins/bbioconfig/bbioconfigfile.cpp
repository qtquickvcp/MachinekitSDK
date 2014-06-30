#include "bbioconfigfile.h"
#include "bbioconfig.h"

#include <QFileInfo>
#include <QDebug>
#include <QQuickItem>

namespace BBIOConfig {
namespace Internal {

BBIOConfigFile::BBIOConfigFile(BBIOConfig *parent, QQuickView *view)
{
    m_editor = parent;
    m_view = view;

    connect(m_view->rootObject(), SIGNAL(modifiedChanged()),
            this, SIGNAL(changed()));
}

bool BBIOConfigFile::save(QString *errorString, const QString &fileName, bool autoSave)
{
    Q_UNUSED(errorString)

    QVariant returnValue;
    QMetaObject::invokeMethod(m_view->rootObject(), "saveDocument",
                              Q_RETURN_ARG(QVariant, returnValue),
                              Q_ARG(QVariant, fileName));

    setDisplayName(m_view->rootObject()->property("currentFileName").toString());
    setFilePath(fileName);

    return returnValue.toBool();
}

bool BBIOConfigFile::setContents(const QByteArray &contents)
{
    Q_UNUSED(contents);
    return false;
}

QString BBIOConfigFile::defaultPath() const
{
    return QString();
}

QString BBIOConfigFile::suggestedFileName() const
{
    return QString();
}

QString BBIOConfigFile::mimeType() const
{
    return m_mimeType;
}

bool BBIOConfigFile::isModified() const
{
    return m_view->rootObject()->property("modified").toBool();
}

bool BBIOConfigFile::isSaveAsAllowed() const
{
    return true;
}

Core::IDocument::ReloadBehavior BBIOConfigFile::reloadBehavior(Core::IDocument::ChangeTrigger state, Core::IDocument::ChangeType type) const
{
    if (type == TypeRemoved || type == TypePermissions)
        return BehaviorSilent;
    if (type == TypeContents && state == TriggerInternal && !isModified())
        return BehaviorSilent;
    return BehaviorAsk;
}

bool BBIOConfigFile::reload(QString *errorString, Core::IDocument::ReloadFlag flag, Core::IDocument::ChangeType type)
{
    qDebug() << "reload";
    if (flag == FlagIgnore)
        return true;
    if (type == TypePermissions) {
        emit changed();
        return true;
    }
    return m_editor->open(errorString, filePath(), filePath());
}

void BBIOConfigFile::setMimetype(const QString &mimetype)
{
    m_mimeType = mimetype;
    emit changed();
}

} // namespace Internal
} // namespace BBIOConfig

#include "bbioconfigfile.h"
#include "bbioconfig.h"

#include <QFileInfo>

namespace BBIOConfig {
namespace Internal {

BBIOConfigFile::BBIOConfigFile(BBIOConfig *parent)
{
    m_editor = parent;
}

bool BBIOConfigFile::save(QString *errorString, const QString &fileName, bool autoSave)
{
    Q_UNUSED(errorString)
    Q_UNUSED(fileName);
    Q_UNUSED(autoSave)
    return false;
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
    return false;
}

bool BBIOConfigFile::isSaveAsAllowed() const
{
    return false;
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

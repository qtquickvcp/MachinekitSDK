#ifndef BBIOCONFIGFILE_H
#define BBIOCONFIGFILE_H

#include <coreplugin/idocument.h>

#include <QQuickView>

namespace BBIOConfig {
namespace Internal {

class BBIOConfig;

class BBIOConfigFile : public Core::IDocument
{
    Q_OBJECT

public:
    explicit BBIOConfigFile(BBIOConfig *parent, QQuickView *view);

    bool save(QString *errorString, const QString &fileName, bool autoSave);
    bool setContents(const QByteArray &contents);

    QString defaultPath() const;
    QString suggestedFileName() const;
    QString mimeType() const;

    bool isModified() const;
    bool isSaveAsAllowed() const;

    ReloadBehavior reloadBehavior(ChangeTrigger state, ChangeType type) const;
    bool reload(QString *errorString, ReloadFlag flag, ChangeType type);

    void setMimetype(const QString &mimetype);

private:
    QString m_mimeType;
    BBIOConfig *m_editor;
    QQuickView *m_view;
};

} // namespace Internal
} // namespace BBIOConfig

#endif // BBIOCONFIGFILE_H

#ifndef BBIOCONFIG_H
#define BBIOCONFIG_H

#include <coreplugin/editormanager/ieditor.h>
#include <coreplugin/idocument.h>

namespace BBIOConfig {
namespace Internal {
class BBIOConfigFile;

class BBIOConfig : public Core::IEditor
{
    Q_OBJECT

public:
    explicit BBIOConfig(QWidget *parent = 0);
    ~BBIOConfig();

    bool open(QString *errorString, const QString &fileName, const QString &realFileName);
    Core::IDocument *document();
    QWidget *toolBar();

signals:

public slots:


private:
    struct BBIOConfigPrivate *d;

};

} // namespace Internal
} // namespace BBIOConfig

#endif // BBIOCONFIG_H

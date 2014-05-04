#ifndef BBIOCONFIGFACTORY_H
#define BBIOCONFIGFACTORY_H

#include "bbioconfigactionhandler.h"

#include <coreplugin/editormanager/ieditorfactory.h>
#include <coreplugin/editormanager/ieditor.h>
#include <coreplugin/idocument.h>

namespace BBIOConfig {
namespace Internal {

class BBIOConfigActionHandler;

class BBIOConfigFactory : public Core::IEditorFactory
{
    Q_OBJECT
public:
    explicit BBIOConfigFactory(QObject *parent = 0);

    Core::IEditor *createEditor();

    void extensionsInitialized();

    private:
        BBIOConfigActionHandler m_actionHandler;

};

} // namespace Internal
} // namespace BBIOConfig

#endif // BBIOCONFIGFACTORY_H

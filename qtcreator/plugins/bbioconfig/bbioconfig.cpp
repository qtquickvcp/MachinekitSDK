#include "bbioconfig.h"
#include "bbioconfigfile.h"
#include "bbioconfigconstants.h"
#include <fileio.h>

#include <coreplugin/icore.h>
#include <coreplugin/actionmanager/actionmanager.h>
#include <coreplugin/actionmanager/command.h>
#include <utils/qtcassert.h>

#include <QQuickView>
#include <QDebug>
#include <QUrl>

namespace BBIOConfig {
namespace Internal {

struct BBIOConfigPrivate
{
    QString displayName;
    QQuickView *view;
    QWidget *container;
    QWidget *toolbar;
    BBIOConfigFile *file;
};

BBIOConfig::BBIOConfig(QWidget *parent) :
    IEditor(parent),
    d(new BBIOConfigPrivate)
{
    setId(Constants::BBIOCONFIG_ID);

    qmlRegisterType<FileIO>("FileIO", 1, 0, "File");

    d->view = new QQuickView();
    d->container = QWidget::createWindowContainer(d->view);
    d->view->setSource(QUrl(QStringLiteral("qrc:///bbioconfig/qml/BBIOConfig.qml")));
    d->view->setResizeMode(QQuickView::SizeRootObjectToView);

    d->file = new BBIOConfigFile(this, d->view);

    setContext(Core::Context(Constants::BBIOCONFIG_ID));
    setWidget(d->container);

    // toolbar
    d->toolbar = new QWidget();
}

BBIOConfig::~BBIOConfig()
{
    delete d->view;
    delete d->container;
    delete d;
}

bool BBIOConfig::open(QString *errorString, const QString &fileName, const QString &realFileName)
{
    QVariant returnValue;
    QMetaObject::invokeMethod(d->view->rootObject(), "openDocument",
                              Q_RETURN_ARG(QVariant, returnValue),
                              Q_ARG(QVariant, fileName));

    d->file->setDisplayName(d->view->rootObject()->property("currentFileName").toString());
    d->file->setFilePath(fileName);

    return returnValue.toBool();
}

Core::IDocument *BBIOConfig::document()
{
    return d->file;
}

QWidget *BBIOConfig::toolBar()
{
    return d->toolbar;
}

} // namespace Internal
} // namespace BBIOConfig

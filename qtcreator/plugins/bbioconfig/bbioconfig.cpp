#include "bbioconfig.h"
#include "bbioconfigfile.h"
#include "bbioconfigconstants.h"

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

    d->file = new BBIOConfigFile(this);

    d->view = new QQuickView();
    d->container = QWidget::createWindowContainer(d->view);
    //container->setMinimumSize(200, 200);
    //container->setMaximumSize(200, 200);
    //container->setFocusPolicy(Qt::TabFocus);
    d->view->setSource(QUrl(QStringLiteral("qrc:///bbioconfig/main.qml")));
    d->view->setResizeMode(QQuickView::SizeRootObjectToView);

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
    qDebug() << "file Name:" << fileName;
    return true;
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

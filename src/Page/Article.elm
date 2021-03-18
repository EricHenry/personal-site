module Page.Article exposing (view)

import Data.Author as Author
import Date exposing (Date)
import Element exposing (Element)
import Element.Font as Font
import Metadata exposing (ArticleMetadata)
import Pages
import Pages.ImagePath as ImagePath exposing (ImagePath)
import Palette


view : ArticleMetadata -> Element msg -> { title : String, body : List (Element msg) }
view metadata viewForPage =
    { title = metadata.title
    , body =
        [ Element.column []
            [ Palette.blogHeading metadata.title
            , publishedDateView metadata |> Element.el [ Element.paddingXY 0 5, Font.size 13, Font.color (Element.rgb255 201 202 204) ]
            ]
        , Element.el [ Font.size 16 ] viewForPage

        --, authorSnippet metadata.author
        ]
    }


authorSnippet : Author.Author -> Element msg
authorSnippet author =
    Element.column [ Element.alignBottom, Element.spacing 10 ]
        [ Element.row [ Element.spacing 10 ]
            [ Author.view [] author
            , Element.column [ Element.spacing 10, Element.width Element.fill ]
                [ Element.paragraph [ Font.bold, Font.size 24 ]
                    [ Element.text author.name
                    ]
                , Element.paragraph [ Font.size 16 ]
                    [ Element.text author.bio ]
                ]
            ]
        ]


publishedDateView : { a | published : Date } -> Element msg
publishedDateView metadata =
    metadata.published
        |> Date.format "yyyy-dd-MM"
        |> Element.text


articleImageView : ImagePath Pages.PathKey -> Element msg
articleImageView articleImage =
    Element.image [ Element.width Element.fill ]
        { src = ImagePath.toString articleImage
        , description = "Article cover photo"
        }

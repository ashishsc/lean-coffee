module Plan exposing (..)
import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (placeholder, value, type')
import Html.App as App

type alias Model =
  { subject : String
  , textInput : String
  , votes : Int
  }

init : (Model, Cmd Msg)
init =
  (Model "" "" 0, Cmd.none)

type Msg = Vote | AddSubject | UpdateTyped String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Vote ->
      ({ model | votes = model.votes + 1 }, Cmd.none)
    AddSubject  ->
      ({ model | subject = model.textInput, textInput = "" }, Cmd.none)
    UpdateTyped newInput ->
    ({ model | textInput = newInput }, Cmd.none)

view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text <| "Subject:" ++ model.subject ]
    , h2 [] [ text <| "Votes:" ++ (toString model.votes) ]
    , input
      [ placeholder "Add a subject to discuss"
      , onInput UpdateTyped
      , type' "text"
      , value model.textInput
      ] []
    , div [] [ button [ onClick AddSubject ] [ text "Add"] ]
    , div [] [ button [ onClick Vote ] [ text "+" ] ]
    ]

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


main : Program Never
main =
  App.program
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }
